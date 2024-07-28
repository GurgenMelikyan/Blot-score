import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Universal
import QtQuick.Layouts
import "qml_resources"

ApplicationWindow {
    Universal.theme: Universal.System
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: "Բլոտի հաշիվ"

    property int largeScoreFactor: 28
    property int smallScoreFactor: 3
    property int scoreHeight: height / 20
    property int minimumScoreWidth: 38
    property int minimumScoreHeight: 25
    property string themedBlue: (Universal.theme == Universal.Light ? "light" : "dark") + "blue"

    ListModel {
        id: gameModel
        ListElement {
            firstScore: 10
            firstDeclarations: 5
            firstBlot: false
            secondScore: 152
            secondDeclarations: 2
            secondBlot: true
            teamThatDeclaredContract: 0
            bid: 13
            trump: 1
            isCapot: true
            modifier: 4
            pointsWonByFirstTeam: 0
            pointsWonBySecondTeam: 0
        }
    }
    header: RowLayout {
        id: namesOfScores
        width: appWindow.width
        height: Math.max(2 * appWindow.scoreHeight, 2 * appWindow.minimumScoreHeight)
        ScoreName {
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: largeScoreFactor
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: appWindow.minimumScoreWidth
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            text: "Մենք"
        }
        ScoreName {
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: smallScoreFactor
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: 50
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            Layout.maximumWidth: Math.max(height / 2, Layout.minimumWidth)
            text: "Դրսից1"
        }
        ScoreName {
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: largeScoreFactor
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: appWindow.minimumScoreWidth
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            text: "Դուք"
        }
        ScoreName {
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: smallScoreFactor
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: 50
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            Layout.maximumWidth: Math.max(height / 2, Layout.minimumWidth)
            text: "Դրսից2"
        }
        Item {  //filler
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: smallScoreFactor
            Layout.minimumWidth: 10
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.maximumWidth: Math.max(height / 2, Layout.minimumWidth)
        }
        Item { // team filler
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: smallScoreFactor
            Layout.minimumWidth: 50
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            Layout.maximumWidth: Math.max(height / 2, Layout.minimumWidth)
        }
        Item { // bid filler
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: smallScoreFactor
            Layout.minimumWidth: appWindow.minimumScoreWidth
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            Layout.maximumWidth: Math.max(height / 2, Layout.minimumWidth)
        }
        ScoreName {
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: smallScoreFactor
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: 50
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            Layout.maximumWidth: Math.max(height / 2, Layout.minimumWidth)
            text: "Խոսացած"
        }
        Item { // contras filler
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: smallScoreFactor
            Layout.minimumWidth: 40
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            Layout.maximumWidth: Math.max(height / 2, Layout.minimumWidth)
        }
        Item { // trump filler
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: smallScoreFactor
            Layout.minimumWidth: 45
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            Layout.maximumWidth: Math.max(height / 2, Layout.minimumWidth)
        }
        Item { //filler
            Layout.fillWidth: true
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
        }
    }
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

            height: Math.max(2 * appWindow.scoreHeight, 2 * appWindow.minimumScoreHeight)
            width: appWindow.width
            
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
                if(teamThatDeclaredContract == 0) {
                    if(firstScore != 162 && 
                        (firstScore == 0 || firstScore < (bid - firstDeclarations - firstBlot * 2) * 10 || isCapot)) //first team lost
                        return [firstBlot * 2,
                                16 + bid * modifier + firstDeclarations + secondDeclarations + secondBlot * 2]
                    else //first team won
                        return [roundPoints(firstScore, true) + bid * modifier + firstDeclarations + firstBlot * 2 +
                                    (modifier > 1 ? secondDeclarations : 0),
                                secondBlot * 2 + (modifier > 1 ? 0 : roundPoints(secondScore, false) + secondDeclarations)]
                }
                else {
                    if(secondScore != 162 && 
                        (secondScore == 0 || secondScore < (bid - secondDeclarations - secondBlot * 2) * 10 || isCapot)) //second team lost
                        return [16 + bid * modifier + secondDeclarations + firstDeclarations + firstBlot * 2,
                                secondBlot * 2]
                    else //second team won
                        return [firstBlot * 2 + (modifier > 1 ? 0 : roundPoints(firstScore, false) + firstDeclarations),
                                roundPoints(secondScore, true) + bid * modifier + secondDeclarations + secondBlot * 2 +
                                    (modifier > 1 ? firstDeclarations : 0)]
                }
            }

            pointsWonByFirstTeam: calculatePointsWon()[0]
            pointsWonBySecondTeam: calculatePointsWon()[1]

            GridLayout {
                anchors.fill: parent

                columns: 11
                //first row -------------------------------------------------------------------------
                ScoreInput { //first score
                    id: firstScoreInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: largeScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    minimalValue: 0
                    maximalValue: 162

                    Component.onCompleted: { text = scores.firstScore }
                    Binding {
                        scores.firstScore: firstScoreInput.text
                        when: firstScoreInput.acceptableInput
                    }
                    Binding {
                        secondScoreInput.text:  162 - firstScoreInput.text
                        when: firstScoreInput.acceptableInput
                    }
                }
                ScoreInput { //first declarations
                    id: firstDeclarationsInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    minimalValue: 0
                    maximalValue: 200
                    text: scores.firstDeclarations
                    Binding { scores.firstDeclarations: firstDeclarationsInput.text }
                }
                ScoreInput { //second score
                    id: secondScoreInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: largeScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    minimalValue: 0
                    maximalValue: 162
                    Component.onCompleted: { text = scores.secondScore }
                    Binding {
                        scores.secondScore: secondScoreInput.text
                        when: secondScoreInput.acceptableInput
                    }
                    Binding {
                        firstScoreInput.text: 162 - secondScoreInput.text
                        when: secondScoreInput.acceptableInput
                    }
                }
                ScoreInput { //second declarations
                    id: secondDeclarationsInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    minimalValue: 0
                    maximalValue: 200
                    text: scores.secondDeclarations
                    Binding { scores.secondDeclarations: secondDeclarationsInput.text }
                }
                Item { //filler
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 10
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                }
                ComboBox { //Team that declared contract
                    id: teamInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 55
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    indicator: Item{}
                    font.pixelSize: Math.min(height, width) / 2.6
                    currentIndex: scores.teamThatDeclaredContract
                    Text { id: selectedTeam; text: parent.currentText; color: "transparent" } // to get size of the team's name
                    leftPadding: (width - selectedTeam.implicitWidth) / 2 - ((width - height < 10) ? 20 : 10) // to center options
                    model: ["Մենք", "Դուք"]
                    Binding { scores.teamThatDeclaredContract: teamInput.currentIndex }
                }
                ScoreInput { //bid
                    id: bidInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    minimalValue: 8
                    maximalValue: 200
                    text: scores.bid
                    Binding { scores.bid: bidInput.text }
                }
                Button { //capot
                    id: capotInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 25
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    text: 'Կ'
                    font.pixelSize: Math.min(height, width) / 2.1
                    checkable: true
                    checked: scores.isCapot
                    onClicked: { scores.isCapot ^= true }
                }
                ComboBox { //contras
                    id: contrasInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 40
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    indicator: Item{}
                    leftPadding: (width - font.pixelSize) / 2 - 13 // to center options
                    font.pixelSize: Math.min(height, width) / 2.1
                    model: [" -", " Ք", " Ս"] // there are some spaces for somewhat correct padding
                    currentIndex: Math.log2(scores.modifier)
                    Binding { scores.modifier: Math.pow(2, contrasInput.currentIndex) }
                }
                ComboBox { //trump
                    id: trumpInput
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 45
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    indicator: Item{}
                    leftPadding: (width - font.pixelSize) / 2 - 15 // to center options
                    font.pixelSize: Math.min(height, width) / 2.1
                    model: ['❤️', '♠️', '♦️', '♣️', " A"] // there is a space before 'A' for somewhat correct padding
                    currentIndex: scores.trump
                    Binding { scores.trump: trumpInput.currentIndex }
                }
                Item { //filler
                    Layout.fillWidth: true
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                }

                //second row -------------------------------------------------------------------------
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    ScoreName {
                        anchors.fill: parent
                        text: "+" + scores.pointsWonByFirstTeam
                    }
                    color: appWindow.themedBlue
                }
                Button { //blot reblot 1
                    id: blotReblot1
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    text: "Բլոտ"
                    font.pixelSize: Math.min(height, width) / 3.5
                    ButtonGroup.group: blotGroupForScores
                    enabled: scores.trump < 4 // enabled if there is a suit selected
                    onEnabledChanged: if(enabled) blotGroupForScores.checkState = Qt.Unchecked
                    checkable: true
                    checked: scores.firstBlot
                    onClicked: {
                        if(checked && blotGroupForScores.lastClicked == blotReblot1) {
                            blotGroupForScores.checkState = Qt.Unchecked
                            blotGroupForScores.lastClicked = null
                        }
                        else
                            blotGroupForScores.lastClicked = blotReblot1
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    ScoreName {
                        anchors.fill: parent
                        reduceFactor: 2.6
                        text: "+" + scores.pointsWonBySecondTeam
                    }
                    color: appWindow.themedBlue
                }
                Button { //blot reblot 2
                    id: blotReblot2
                    Layout.fillWidth: true
                    Layout.horizontalStretchFactor: smallScoreFactor
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                    text: "Բլոտ"
                    font.pixelSize: Math.min(height, width) / 3.5
                    ButtonGroup.group: blotGroupForScores
                    enabled: scores.trump < 4 // enabled if there is a suit selected
                    onEnabledChanged: if(enabled) blotGroupForScores.checkState = Qt.Unchecked
                    checkable: true
                    checked: scores.secondBlot
                    onClicked: {
                        if(checked && blotGroupForScores.lastClicked == blotReblot2) {
                            blotGroupForScores.checkState = Qt.Unchecked
                            blotGroupForScores.lastClicked = null
                        }
                        else
                            blotGroupForScores.lastClicked = blotReblot2
                    }
                }
            }
        }
    }
    
    footer: Rectangle {

        width: appWindow.width
        height: Math.max(2 * appWindow.scoreHeight, 2 * appWindow.minimumScoreHeight)
        color: appWindow.themedBlue
        Universal.theme: Universal.System
        
        ButtonGroup {
            id: blotGroupForAddingScores
            property var lastClicked: null
        }

        RowLayout {
            anchors.fill: parent
            //first row
            ScoreInput { //first score
                id: currentFirstScore
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: largeScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: appWindow.minimumScoreWidth
                Layout.minimumHeight: appWindow.minimumScoreHeight
                minimalValue: 0
                maximalValue: 162
                Binding {
                    target: currentSecondScore
                    property: "text"
                    value:  162 - currentFirstScore.text
                    when: currentFirstScore.acceptableInput
                }
            }
            ColumnLayout {
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: 2 * appWindow.scoreHeight
                Layout.minimumWidth: appWindow.minimumScoreWidth
                Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
                Layout.maximumWidth: Math.max((height - Layout.columnSpacing) / 2, Layout.minimumWidth)
                ScoreInput { //first declarations
                    id: currentFirstDeclarations
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    minimalValue: 0
                    maximalValue: 200
                    text: '0'
                }
                Button { //blot reblot 1
                    id: currentBlotReblot1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
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
            }
            ScoreInput { //second score
                id: currentSecondScore
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: largeScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: appWindow.minimumScoreWidth
                Layout.minimumHeight: appWindow.minimumScoreHeight
                minimalValue: 0
                maximalValue: 162
                Binding {
                    target: currentFirstScore
                    property: "text"
                    value:  162 - currentSecondScore.text
                    when: currentSecondScore.acceptableInput
                }
            }
            ColumnLayout {
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: 2 * appWindow.scoreHeight + Layout.columnSpacing
                Layout.minimumWidth: appWindow.minimumScoreWidth
                Layout.minimumHeight: 2 * appWindow.minimumScoreHeight + Layout.columnSpacing
                Layout.maximumWidth: Math.max((height - Layout.columnSpacing) / 2, Layout.minimumWidth)
                ScoreInput { //second declarations
                    id: currentSecondDeclarations
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    minimalValue: 0
                    maximalValue: 200
                    text: '0'
                }
                Button { //blot reblot 2
                    id: currentBlotReblot2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
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
            }
            Item { //filler
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 10
                Layout.minimumHeight: appWindow.minimumScoreHeight
                Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
            }
            ComboBox { //Team that declared contract
                id: currentTeamInput
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 55
                Layout.minimumHeight: appWindow.minimumScoreHeight
                Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                indicator: Item{}
                font.pixelSize: Math.min(height, width) / 2.6
                Text { id: selectedTeam; text: parent.currentText; color: "transparent" } // to get size of the team's name
                leftPadding: (width - selectedTeam.implicitWidth) / 2 - ((width - height < 10) ? 20 : 10) // to center options
                model: ["Մենք", "Դուք"]
            }
            ScoreInput { //bid
                id: currentBid
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: appWindow.minimumScoreWidth
                Layout.minimumHeight: appWindow.minimumScoreHeight
                Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                minimalValue: 8
                maximalValue: 200
            }
            Button { //capot
                id: currentCapotStatus
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 25
                Layout.minimumHeight: appWindow.minimumScoreHeight
                Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                text: 'Կ'
                font.pixelSize: Math.min(height, width) / 2.1
                checkable: true
            }
            ComboBox { //contras
                id: currentModifier
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 40
                Layout.minimumHeight: appWindow.minimumScoreHeight
                Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                indicator: Item{}
                leftPadding: (width - font.pixelSize) / 2 - 13 // to center options
                font.pixelSize: Math.min(height, width) / 2.1
                model: [" -", " Ք", " Ս"] // there are some spaces for somewhat correct padding
            }
            ComboBox { //trump
                id: currentTrump
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 45
                Layout.minimumHeight: appWindow.minimumScoreHeight
                Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                indicator: Item{}
                leftPadding: (width - font.pixelSize) / 2 - 15 // to center options
                font.pixelSize: Math.min(height, width) / 2.1
                model: ['❤️', '♠️', '♦️', '♣️', " A"] // there is a space before 'A' for somewhat correct padding
            }
            Item { //filler
                Layout.fillWidth: true
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumHeight: appWindow.minimumScoreHeight
            }
            RoundButton { // add button
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: smallScoreFactor
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 25
                Layout.minimumHeight: appWindow.minimumScoreHeight
                Layout.maximumWidth: Math.max(height, Layout.minimumWidth)
                text: '+'
                font.pixelSize: Math.min(height, width) / 2.1
                highlighted: true
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
                    }
                }
            }
            Item { //filler
                Layout.minimumWidth: 10
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumHeight: appWindow.minimumScoreHeight
            }
        }
    }
}