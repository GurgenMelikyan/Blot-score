import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Universal
import QtQuick.Layouts
import QtCore
import "qml_resources"

ApplicationWindow {
    Universal.theme: currentTheme
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: "Բլոտի հաշիվ"

    property string firstTeamName: "Մենք"
    property string secondTeamName: "Դուք"
    property int pointsAccumulated1: 0
    property int pointsAccumulated2: 0

    property int largeScoreFactor: 22
    property int smallScoreFactor: 3
    property int scoreHeight: height / 20
    property int minimumScoreWidth: 50
    property int minimumScoreHeight: 25
    property int currentTheme: settings.appTheme
    property string backgroundColor: Universal.theme == Universal.Light ? "white" : "black"
    property string textColor: Universal.theme == Universal.Light ? "black" : "white"
    property string backColor: Universal.theme == Universal.Light ? "darkgray" : "dimgray"
    property string frontColor: Universal.theme == Universal.Light ? "lightgray" : "gray"

    ListModel {
        id: gameModel
    }
    header:  Column { Rectangle {
        width: appWindow.width
        height: 5 + Math.max(2 * appWindow.scoreHeight, 2 * appWindow.minimumScoreHeight)
        color: appWindow.backColor
        RowLayout {
                anchors.fill: parent
                RoundButton { // help button
                    Layout.fillWidth: true
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 25
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    icon.source: "icons/question.png"
                    icon.width: width
                    icon.height: height
                    font.pixelSize: Math.min(height, width) / 2.1
                    onClicked: helpPage.open()
                    Popup {
                        id: helpPage
                        width: appWindow.width - parent.width
                        height: appWindow.height - parent.height
                        x: parent.width
                        y: parent.height
                        ScrollView{
                            anchors.fill: parent
                            font.pixelSize: Math.min(width, height) / 20
                            TextArea {
                                anchors.fill: parent
                                onFocusChanged: focus = false
                                selectByMouse: false
                                readOnly: true
                                background: Item{}
                                text: "Մուտքագրեք թմերի հավաքած սաիները (0-ից 162) համապատասխան դաշտերում։\n" + //really unproffesional, I know
                                      "Նշեք թե ինչ ունեք դրսից(չհաշված բլոտ-ռեբլոտ)։\n" +
                                      "<<Հայտարարել են>> բաժնում նշեք որ թիմն է խոսասացել իր մաանրամասներով։\n"+
                                      "Այնուհետև սեղմեք '+' կոճակին խաղը ավելացնելու համար։\n"+
                                      "Կարող եք հեռացնել վերջին խաղը '-' կոճակով։\n\n"+

                                      "Յուրաքանչյուր խաղի տվյալները կարելի է փոխել ավելացնելուց հետո,\n"+
                                      "ուղղակի սեղմեք համապատասխան դաշտի վրա։\n"+
                                      "Խաղի ընդհանուր հաշիվը ցույց է տրված ներքևի 2 դաշտերում։\n"
                                wrapMode: TextArea.WordWrap
                            }
                        }
                    }
                }
                ScoreName {
                    id: firstTeamNameInput
                    Layout.fillWidth: true
                    Layout.preferredHeight: 2 * appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
                    text: appWindow.firstTeamName
                    editable: true
                    Binding {
                        appWindow.firstTeamName: firstTeamNameInput.text
                    }
                }
                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.fillHeight: true
                    color: Universal.theme == Universal.Light ? "dimgray" : "darkgray"
                }
                ScoreName {
                    id: secondTeamNameInput
                    Layout.fillWidth: true
                    Layout.preferredHeight: 2 * appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
                    text: appWindow.secondTeamName
                    editable: true
                    Binding {
                        appWindow.secondTeamName: secondTeamNameInput.text
                    }
                }
                RoundButton { // settings button
                    Layout.fillWidth: true
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 25
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    icon.source: "icons/settings.png"
                    icon.width: width
                    icon.height: height
                    font.pixelSize: Math.min(height, width) / 2.1
                    onClicked: settingsMenu.open()
                    Popup {
                        id: settingsMenu
                        width: Math.max(appWindow.width / 5, 150)
                        height: Math.max(appWindow.height / 2, 200)
                        x: -width
                        y: parent.height
                        font.pixelSize: Math.min(width, height) / 15
                        ColumnLayout {
                            anchors.fill: parent
                            TextField {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.horizontalStretchFactor: 1
                                onFocusChanged: focus = false
                                selectByMouse: false
                                readOnly: true
                                background: Item{}
                                text: "Գունային ռեժիմ`" 
                                horizontalAlignment: TextInput.AlignLeft
                                wrapMode: TextInput.WordWrap
                            }
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.horizontalStretchFactor: 4
                                RadioButton {
                                    id: lightThemeButton
                                    Layout.fillWidth: true
                                    text: "Բաց"
                                    checked: settings.appTheme == Universal.Light
                                    onClicked: appWindow.currentTheme = Universal.Light
                                }
                                RadioButton {
                                    id: darkThemeButton
                                    Layout.fillWidth: true
                                    text: "Մուգ"
                                    checked: settings.appTheme == Universal.Dark
                                    onClicked: appWindow.currentTheme = Universal.Dark
                                }
                                RadioButton {
                                    id: systemThemeButton
                                    Layout.fillWidth: true
                                    text: "Ներքին"
                                    checked: settings.appTheme == Universal.System
                                    onClicked: appWindow.currentTheme = Universal.System
                                }
                            }
                            Switch {
                                id: noTrump2xSwitch
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.horizontalStretchFactor: 1
                                text: "A 2×" 
                                ToolTip.visible: hovered
                                ToolTip.text: "Անղոզ խաղի ժամանակ կրկնակի շատ միավոր"
                                checked: settings.noTrump2x
                            }
                        }
                    }
                    Settings {
                        id: settings
                        property int appTheme: Universal.System
                        property bool noTrump2x: false
                    }
                    Component.onDestruction: {
                        if(lightThemeButton.checked)
                            settings.appTheme = Universal.Light
                        if(darkThemeButton.checked)
                            settings.appTheme = Universal.Dark
                        if(systemThemeButton.checked)
                            settings.appTheme = Universal.System
                        settings.noTrump2x = noTrump2xSwitch.checked
                    }
                }
        }
        } Rectangle { width: appWindow.width; height: 20; color: appWindow.backgroundColor} }
    ListView {
        anchors.fill: parent
        spacing: 15
        model: gameModel
        delegate: Item {
            id: scores
            required property int firstScore
            required property int firstDeclarations
            required property bool firstBlot
            required property int secondScore
            required property int secondDeclarations
            required property bool secondBlot
            required property int teamThatDeclaredContract
            required property int bid
            required property int trump
            required property bool isCapot
            required property int modifier
            required property int pointsWonByFirstTeam
            required property int pointsWonBySecondTeam

            property int pointsWon1: 0 // used in accumulation
            property int pointsWon2: 0 // used in accumulation

            height: Math.max(2 * appWindow.scoreHeight, 2 * appWindow.minimumScoreHeight)
            width: appWindow.width
            
            onFirstDeclarationsChanged: secondDeclarationsInput.text = '0'
            onSecondDeclarationsChanged: firstDeclarationsInput.text = '0'

            ButtonGroup {
                id: blotGroupForScores
                property var lastClicked: null
            }
            
            function roundPoints(number, thisTeamDeclaredContract)
            {
                if(number == 162)
                    return 25
                if(number % 10 < 6 || (number % 10 == 6 && thisTeamDeclaredContract))
                    return Math.trunc(number / 10)
                return Math.trunc(number / 10) + 1
            }

            function calculatePointsWon()
            {
                let pointsWon1, pointsWon2, noTrumpIndex = 4, trump2x

                if(noTrump2xSwitch.checked && trump == noTrumpIndex)
                    trump2x = 2
                else
                    trump2x = 1

                if(teamThatDeclaredContract == 0)
                    if(firstScore == 0 || (firstScore == 162 ? 250 : firstScore) < (bid - firstDeclarations - firstBlot * 2) * 10 || isCapot) { //first team lost
                        pointsWon1 = firstBlot * 2
                        pointsWon2 = 16 + bid * modifier * trump2x + firstDeclarations + secondDeclarations + secondBlot * 2
                    }
                    else { //first team won
                        pointsWon1 = roundPoints(firstScore, true) + bid * modifier * trump2x + firstDeclarations + firstBlot * 2 +
                                    (modifier > 1 ? secondDeclarations : 0)
                        pointsWon2 = secondBlot * 2 + (modifier > 1 ? 0 : roundPoints(secondScore, false) + secondDeclarations)
                    }
                else
                    if(secondScore == 0 || (secondScore == 162 ? 250 : secondScore) < (bid - secondDeclarations - secondBlot * 2) * 10 || isCapot) {//second team lost
                        pointsWon1 = 16 + bid * modifier * trump2x + secondDeclarations + firstDeclarations + firstBlot * 2
                        pointsWon2 = secondBlot * 2
                    }
                    else { //second team won
                        pointsWon1 = firstBlot * 2 + (modifier > 1 ? 0 : roundPoints(firstScore, false) + firstDeclarations)
                        pointsWon2 = roundPoints(secondScore, true) + bid * modifier * trump2x + secondDeclarations + secondBlot * 2 +
                                    (modifier > 1 ? firstDeclarations : 0)
                    }
                return [pointsWon1, pointsWon2]
            }

            pointsWonByFirstTeam: calculatePointsWon()[0]
            pointsWonBySecondTeam: calculatePointsWon()[1]

            onPointsWonByFirstTeamChanged: {
                appWindow.pointsAccumulated1 -= pointsWon1
                appWindow.pointsAccumulated1 += pointsWonByFirstTeam
                pointsWon1 = pointsWonByFirstTeam
            }
            onPointsWonBySecondTeamChanged: {
                appWindow.pointsAccumulated2 -= pointsWon2
                appWindow.pointsAccumulated2 += pointsWonBySecondTeam
                pointsWon2 = pointsWonBySecondTeam
            }
            RowLayout{
                height: parent.height
                width: parent.width
                Item {} //filler
                Rectangle { // first team
                        id: firstTeamScore
                        height: parent.height
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: Math.min(width, height) / 3
                        color: appWindow.frontColor
                        ScoreName {
                            anchors.fill: parent
                            text: "+" + scores.pointsWonByFirstTeam
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: firstTeamMenu.popup(0, height + 10)
                        }
                        Menu {
                            id: firstTeamMenu
                            title: appWindow.firstTeamName
                            width: appWindow.width
                            GridLayout {
                                width: parent.width
                                height: 2 * appWindow.scoreHeight + columnSpacing
                                columns: 3
                                ScoreName {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 80
                                    text: "Հավաքած միավոր"
                                }
                                ScoreInput { //first score
                                    id: firstScoreInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: appWindow.minimumScoreWidth
                                    Layout.columnSpan: 2
                                    minimalValue: 0
                                    maximalValue: 162
                                    text: { text = scores.firstScore }
                                    Binding {
                                        scores.firstScore: firstScoreInput.text
                                        when: firstScoreInput.acceptableInput
                                    }
                                    Binding {
                                        secondScoreInput.text:  162 - firstScoreInput.text
                                        when: firstScoreInput.acceptableInput
                                    }
                                }
                                ScoreName {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 80
                                    text: "Դրսից միավորներ"
                                }
                                Button { //blot reblot 1
                                    id: blotReblot1
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: appWindow.minimumScoreWidth
                                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                                    text: "Բլոտ"
                                    font.pixelSize: Math.min(height, width) / 3.5
                                    ButtonGroup.group: blotGroupForScores
                                    enabled: scores.trump < 4 // enabled if there is a suit selected
                                    checkable: true
                                    checked: scores.firstBlot && scores.trump < 4
                                    Binding { scores.firstBlot: blotReblot1.checked }
                                    onClicked: {
                                        if(checked && blotGroupForScores.lastClicked == blotReblot1) {
                                            blotGroupForScores.checkState = Qt.Unchecked
                                            blotGroupForScores.lastClicked = null
                                        }
                                        else
                                            blotGroupForScores.lastClicked = blotReblot1
                                    }
                                }
                                ScoreInput { //first declarations
                                    id: firstDeclarationsInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: appWindow.minimumScoreWidth
                                    minimalValue: 0
                                    maximalValue: 200
                                    text: { text = scores.firstDeclarations }
                                    Binding { 
                                        scores.firstDeclarations: firstDeclarationsInput.text
                                        when: firstDeclarationsInput.acceptableInput
                                    }
                                }
                            }
                        }
                }
                ScoreName { //declarations
                        height: parent.height
                        widthForPixelSize: appWindow.width / 3
                        reduceFactor: 3.5
                        implicitWidth: textWidth
                        Layout.fillHeight: true
                        text: {
                            let declaration = ""
                            declaration += bidInput.text + (capotInput.checked ? 'K' : '')
                            switch(contrasInput.currentIndex) {
                                case 1: declaration += 'Ք'; break
                                case 2: declaration += 'Ս'
                            }
                            switch(trumpInput.currentIndex) {
                                case 0: declaration += '❤️'; break
                                case 1: declaration += '♠️'; break
                                case 2: declaration += '♦️'; break
                                case 3: declaration += '♣️'; break
                                case 4: declaration += 'A'
                            }
                            return declaration
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: declarationsMenu.popup(0, height + 10)
                        }
                        Menu {
                            id: declarationsMenu
                            title: "Հայտարարել ենք"
                            width: Math.max(appWindow.width / 2, 25 + 2 * appWindow.minimumScoreWidth)
                            rightPadding: -50 + (appWindow.width -  width) / 2 // for centering the popup
                            rightInset: -50 + (appWindow.width -  width) / 2 // for centering the popup
                            leftPadding: -(appWindow.width -  width) / 2
                            leftInset: -(appWindow.width -  width) / 2
                            bottomMargin: parent.height + generalScoreRow.height
                            GridLayout {
                                width: parent.width
                                height: 2 * appWindow.scoreHeight + columnSpacing
                                columns: 3
                                ComboBox { //Team that declared contract
                                    id: teamInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: appWindow.minimumScoreWidth
                                    indicator: Item{}
                                    font.pixelSize: Math.min(height, width) / 2.6
                                    currentIndex: { currentIndex = scores.teamThatDeclaredContract }
                                    Text { id: selectedTeam; text: parent.currentText; color: "transparent" } // to get size of the team's name
                                    leftPadding: (width - selectedTeam.implicitWidth) / 2 - ((width - height < 10) ? 20 : 10) // to center options
                                    model: [appWindow.firstTeamName, appWindow.secondTeamName]
                                    Binding { scores.teamThatDeclaredContract: teamInput.currentIndex }
                                }
                                Button { //capot
                                    id: capotInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 25
                                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                                    text: 'Կ'
                                    font.pixelSize: Math.min(height, width) / 2.1
                                    checkable: true
                                    checked: { checked = scores.isCapot }
                                    onClicked: { scores.isCapot ^= true }
                                }
                                ScoreInput { //bid
                                    id: bidInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: appWindow.minimumScoreWidth
                                    minimalValue: 8
                                    maximalValue: 200
                                    text: { text = scores.bid }
                                    Binding { scores.bid: bidInput.text }
                                }
                                ComboBox { //contras
                                    id: contrasInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 55
                                    indicator: Item{}
                                    leftPadding: (width - font.pixelSize) / 2 - 13 // to center options
                                    font.pixelSize: Math.min(height, width) / 2.1
                                    model: [" -", " Ք", " Ս"] // there are some spaces for somewhat correct padding
                                    currentIndex: { currentIndex = Math.log2(scores.modifier) }
                                    Binding { scores.modifier: Math.pow(2, contrasInput.currentIndex) }
                                }
                                ComboBox { //trump
                                    id: trumpInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 45
                                    Layout.columnSpan: 2
                                    indicator: Item{}
                                    leftPadding: (width - font.pixelSize) / 2 - 15 // to center options
                                    font.pixelSize: Math.min(height, width) / 2.1
                                    model: ['❤️', '♠️', '♦️', '♣️', " A"] // there is a space before 'A' for somewhat correct padding
                                    currentIndex: { currentIndex = scores.trump }
                                    Binding { scores.trump: trumpInput.currentIndex }
                                }
                            }
                        }
                }
                Rectangle { // second team
                        id: secondTeamScore
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: Math.min(width, height) / 3
                        color: appWindow.frontColor
                        ScoreName {
                            anchors.fill: parent
                            text: "+" + scores.pointsWonBySecondTeam
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: secondTeamMenu.popup(0, height + 10)
                        }
                        Menu {
                            id: secondTeamMenu
                            title: appWindow.firstTeamName
                            width: appWindow.width
                            GridLayout {
                                width: parent.width
                                height: 2 * appWindow.scoreHeight + columnSpacing
                                columns: 3
                                ScoreName {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 80
                                    text: "Հավաքած միավոր"
                                }
                                ScoreInput { //second score
                                    id: secondScoreInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: appWindow.minimumScoreWidth
                                    Layout.columnSpan: 2
                                    minimalValue: 0
                                    maximalValue: 162
                                    text: { text = scores.secondScore }
                                    Binding {
                                        scores.secondScore: secondScoreInput.text
                                        when: secondScoreInput.acceptableInput
                                    }
                                    Binding {
                                        firstScoreInput.text: 162 - secondScoreInput.text
                                        when: secondScoreInput.acceptableInput
                                    }
                                }
                                ScoreName {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: 80
                                    text: "Դրսից միավորներ"
                                }
                                Button { //blot reblot 2
                                    id: blotReblot2
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: appWindow.minimumScoreWidth
                                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                                    text: "Բլոտ"
                                    font.pixelSize: Math.min(height, width) / 3.5
                                    ButtonGroup.group: blotGroupForScores
                                    enabled: scores.trump < 4 // enabled if there is a suit selected
                                    checkable: true
                                    checked: scores.secondBlot && scores.trump < 4
                                    Binding { scores.secondBlot: blotReblot2.checked }
                                    onClicked: {
                                        if(checked && blotGroupForScores.lastClicked == blotReblot2) {
                                            blotGroupForScores.checkState = Qt.Unchecked
                                            blotGroupForScores.lastClicked = null
                                        }
                                        else
                                            blotGroupForScores.lastClicked = blotReblot2
                                    }
                                }
                                ScoreInput { //second declarations
                                    id: secondDeclarationsInput
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumWidth: appWindow.minimumScoreWidth
                                    minimalValue: 0
                                    maximalValue: 200
                                    text: { text = scores.secondDeclarations }
                                    Binding { 
                                        scores.secondDeclarations: secondDeclarationsInput.text
                                        when: secondDeclarationsInput.acceptableInput
                                    }
                                }
                            }
                        }
                }
                Item {} //filler
            }
        }
    }

    footer: Column {
        MenuBar{
            id: currentMenuBar
            width: appWindow.width
            height: appWindow.scoreHeight * 4 / 3
            delegate: MenuBarItem {
                id: menuBarItem
                topPadding: 0
                bottomPadding: 0

                contentItem: Text {
                    text: menuBarItem.text
                    font.pixelSize: Math.min(parent.background.implicitHeight, parent.background.implicitWidth) / 2.6
                    opacity: enabled ? 1.0 : 0.3
                    color: menuBarItem.highlighted ? appWindow.backgroundColor : appWindow.textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: currentMenuBar.width / currentMenuBar.menus.length
                    implicitHeight: currentMenuBar.height
                    opacity: enabled ? 1 : 0.3
                    color: menuBarItem.highlighted ? "gray" : "transparent"
                }
            }
            ButtonGroup {
                id: blotGroupForAddingScores
                property var lastClicked: null
            }
            Menu { //first team
                title: appWindow.firstTeamName
                width: appWindow.width
                bottomMargin: parent.height + generalScoreRow.height
                GridLayout {
                    width: parent.width
                    height: 2 * appWindow.scoreHeight + columnSpacing
                    columns: 3
                    ScoreName {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 80
                        text: "Հավաքած միավոր"
                    }
                    ScoreInput { //first score
                        id: currentFirstScore
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: appWindow.minimumScoreWidth
                        Layout.columnSpan: 2
                        minimalValue: 0
                        maximalValue: 162
                        Binding {
                            target: currentSecondScore
                            property: "text"
                            value:  162 - currentFirstScore.text
                            when: currentFirstScore.acceptableInput
                        }
                    }
                    ScoreName {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 80
                        text: "Դրսից միավորներ"
                    }
                    Button { //blot reblot 1
                        id: currentBlotReblot1
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: appWindow.minimumScoreWidth
                        Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                        text: "Բլոտ"
                        font.pixelSize: Math.min(height, width) / 3.5
                        ButtonGroup.group: blotGroupForAddingScores
                        enabled: currentTrump.currentIndex < 4 // enabled if there is a suit selected
                        onEnabledChanged: if(enabled) blotGroupForAddingScores.checkState = Qt.Unchecked
                        checkable: true
                        onClicked: {
                            if(checked && blotGroupForAddingScores.lastClicked == currentBlotReblot1) {
                                blotGroupForAddingScores.checkState = Qt.Unchecked
                                blotGroupForAddingScores.lastClicked = null
                            }
                            else
                                blotGroupForAddingScores.lastClicked = currentBlotReblot1
                        }
                    }
                    ScoreInput { //first declarations
                        id: currentFirstDeclarations
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: appWindow.minimumScoreWidth
                        minimalValue: 0
                        maximalValue: 200
                        text: '0'
                        onTextChanged: currentSecondDeclarations.text = '0'
                    }
                }
            }
            Menu { //declarations
                title: "Հայտարարել են"
                width: Math.max(appWindow.width / 2, 25 + 2 * appWindow.minimumScoreWidth)
                leftInset: -appWindow.width / 6 // 1/3 - 1/2 = 1/6
                leftPadding: -appWindow.width / 6 // for centering the popup
                bottomMargin: parent.height + generalScoreRow.height
                GridLayout{
                    width: parent.width
                    height: 2 * appWindow.scoreHeight + columnSpacing
                    columns: 3
                    ComboBox { //Team that declared contract
                        id: currentTeamInput
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: appWindow.minimumScoreWidth
                        indicator: Item{}
                        font.pixelSize: Math.min(height, width) / 2.6
                        Text { id: selectedTeam; text: parent.currentText; color: "transparent" } // to get size of the team's name
                        leftPadding: (width - selectedTeam.implicitWidth) / 2 - ((width - height < 10) ? 20 : 10) // to center options
                        model: [appWindow.firstTeamName, appWindow.secondTeamName]
                    }
                    Button { //capot
                        id: currentCapotStatus
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 25
                        Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                        text: 'Կ'
                        font.pixelSize: Math.min(height, width) / 2.1
                        checkable: true
                    }
                    ScoreInput { //bid
                        id: currentBid
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: appWindow.minimumScoreWidth
                        minimalValue: 8
                        maximalValue: 200
                    }
                    ComboBox { //contras
                        id: currentModifier
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 55
                        indicator: Item{}
                        leftPadding: (width - font.pixelSize) / 2 - 13 // to center options
                        font.pixelSize: Math.min(height, width) / 2.1
                        model: [" -", " Ք", " Ս"] // there are some spaces for somewhat correct padding
                    }
                    ComboBox { //trump
                        id: currentTrump
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 45
                        Layout.columnSpan: 2
                        indicator: Item{}
                        leftPadding: (width - font.pixelSize) / 2 - 15 // to center options
                        font.pixelSize: Math.min(height, width) / 2.1
                        model: ['❤️', '♠️', '♦️', '♣️', " A"] // there is a space before 'A' for somewhat correct padding
                    }
                }
            }
            Menu { //second team
                title: appWindow.secondTeamName
                width: appWindow.width
                bottomMargin: parent.height + generalScoreRow.height
                GridLayout {
                    id: secondTeamInput
                    width: parent.width
                    height: 2 * appWindow.scoreHeight + columnSpacing
                    columns: 3
                    ScoreName {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 80
                        text: "Հավաքած միավոր"
                    }
                    ScoreInput { //second score
                        id: currentSecondScore
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: appWindow.minimumScoreWidth
                        Layout.columnSpan: 2
                        minimalValue: 0
                        maximalValue: 162
                        Binding {
                            target: currentFirstScore
                            property: "text"
                            value:  162 - currentSecondScore.text
                            when: currentSecondScore.acceptableInput
                        }
                    }
                    ScoreName {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 80
                        text: "Դրսից միավորներ"
                    }
                    Button { //blot reblot 2
                        id: currentBlotReblot2
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: appWindow.minimumScoreWidth
                        Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                        text: "Բլոտ"
                        font.pixelSize: Math.min(height, width) / 3.5
                        ButtonGroup.group: blotGroupForAddingScores
                        enabled: currentTrump.currentIndex < 4 // enabled if there is a suit selected
                        onEnabledChanged: if(enabled) blotGroupForAddingScores.checkState = Qt.Unchecked
                        checkable: true
                        onClicked: {
                            if(checked && blotGroupForAddingScores.lastClicked == currentBlotReblot2) {
                                blotGroupForAddingScores.checkState = Qt.Unchecked
                                blotGroupForAddingScores.lastClicked = null
                            }
                            else
                                blotGroupForAddingScores.lastClicked = currentBlotReblot2
                        }
                    }
                    ScoreInput { //second declarations
                        id: currentSecondDeclarations
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: appWindow.minimumScoreWidth
                        minimalValue: 0
                        maximalValue: 200
                        text: '0'
                        onTextChanged: currentFirstDeclarations.text = '0'
                    }
                }
            }
        }
        Rectangle { // score row
            id: generalScoreRow
            width: appWindow.width
            height: 1.5 * appWindow.scoreHeight + 10
            color: appWindow.backColor
            RowLayout {
                anchors.fill: parent
                Item {} //filler
                Rectangle { // points accumulated by the first team
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: 3
                    Layout.preferredHeight: 1.5 * appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: 1.5 * appWindow.minimumScoreHeight
                    color: appWindow.frontColor
                    radius: Math.min(width, height) / 3
                    ScoreName { 
                        anchors.fill: parent
                        reduceFactor: 2.6
                        text: appWindow.pointsAccumulated1
                    }
                }
                RoundButton { // add button
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: 1
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 25
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    text: '+'
                    font.pixelSize: Math.min(height, width) / 2.1
                    onClicked: {
                        if(currentFirstScore.acceptableInput &&
                            currentFirstDeclarations.acceptableInput &&
                            currentSecondScore.acceptableInput &&
                            currentSecondDeclarations.acceptableInput &&
                            currentBid.acceptableInput)
                        {
                            gameModel.append({
                                "firstScore": Number.fromLocaleString(currentFirstScore.text),
                                "firstDeclarations": Number.fromLocaleString(currentFirstDeclarations.text),
                                "firstBlot": currentBlotReblot1.checked,
                                "secondScore": Number.fromLocaleString(currentSecondScore.text),
                                "secondDeclarations": Number.fromLocaleString(currentSecondDeclarations.text),
                                "secondBlot": currentBlotReblot2.checked,
                                "teamThatDeclaredContract": currentTeamInput.currentIndex,
                                "bid": Number.fromLocaleString(currentBid.text),
                                "isCapot":  currentCapotStatus.checked,
                                "modifier": Math.pow(2, currentModifier.currentIndex),
                                "trump": currentTrump.currentIndex,
                                "pointsWonByFirstTeam": 0,
                                "pointsWonBySecondTeam": 0
                            })
                            currentFirstDeclarations.text = 0
                            currentBlotReblot1.checked  = false
                            currentSecondDeclarations.text = 0
                            currentBlotReblot2.checked = false
                            currentTeamInput.currentIndex = 0
                            currentBid.text = ""
                            currentCapotStatus.checked = false
                            currentModifier.currentIndex = 0
                            currentTrump.currentIndex = 0
                        }
                    }
                }
                RoundButton { // remove button
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: 1
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 25
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    text: '-'
                    font.pixelSize: Math.min(height, width) / 2.1
                    onClicked: {
                        appWindow.pointsAccumulated1 -= gameModel.get(gameModel.count - 1).pointsWonByFirstTeam
                        appWindow.pointsAccumulated2 -= gameModel.get(gameModel.count - 1).pointsWonBySecondTeam
                        gameModel.remove(gameModel.count - 1)
                    }
                }
                Rectangle { // points accumulated by the second team
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: 3
                    Layout.preferredHeight: 1.5 * appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: 1.5 * appWindow.minimumScoreHeight
                    color: appWindow.frontColor
                    radius: Math.min(width, height) / 3
                    ScoreName { 
                        anchors.fill: parent
                        reduceFactor: 2.6
                        text: appWindow.pointsAccumulated2
                    }
                }
                Item {} //filler
            }
        }
    }
}