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

    property int largeScoreWidth: width / 3
    property int smallScoreWidth: width / 25
    property int scoreHeight: height / 20
    property int minimumScoreWidth: 38
    property int minimumScoreHeight: 25

    ListModel {
        id: gameModel
        ListElement {
            firstScore: 10
            firstDeclarations: 5
            secondScore: 152
            secondDeclarations: 2
            bid: 13
            trump: 1
            isCapot: true
            modifier: 4
        }
    }
    header: RowLayout {
        id: namesOfScores
        width: appWindow.width
        height: Math.max(2 * appWindow.scoreHeight, 2 * appWindow.minimumScoreHeight)
        ScoreName {
            Layout.preferredWidth: appWindow.largeScoreWidth
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: appWindow.minimumScoreWidth
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            text: "Մենք"
        }
        ScoreName {
            Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: 50
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            text: "Դրսից1"
        }
        ScoreName {
            Layout.preferredWidth: appWindow.largeScoreWidth
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: appWindow.minimumScoreWidth
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            text: "Դուք"
        }
        ScoreName {
            Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: 50
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            text: "Դրսից2"
        }
        Item {  //filler
            Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
            Layout.minimumWidth: 10
            Layout.preferredHeight: appWindow.scoreHeight
        }
        ScoreName {
            Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumWidth: 50
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
            text: "Խոսացած"
        }
        Item { //filler
            Layout.fillWidth: true
            Layout.preferredHeight: appWindow.scoreHeight
            Layout.minimumHeight: 2 * appWindow.minimumScoreHeight
        }
    }
    ListView {
        anchors.fill: parent
        model: gameModel
        delegate: Item {
            id: scores
            required property int firstScore
            required property int firstDeclarations
            required property int secondScore
            required property int secondDeclarations
            required property int bid
            required property int trump
            required property bool isCapot
            required property int modifier

            height: Math.max(2 * appWindow.scoreHeight, 2 * appWindow.minimumScoreHeight)
            width: appWindow.width

            RowLayout {
                anchors.fill: parent

                //first row
                ScoreInput { //first score
                    id: firstScoreInput
                    Layout.preferredWidth: appWindow.largeScoreWidth
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    minimalValue: 0
                    maximalValue: 162
                    Component.onCompleted: {
                        text = scores.firstScore
                    }
                    Binding {
                        target: scores
                        property: "firstScore"
                        value: firstScoreInput.text
                        when: firstScoreInput.acceptableInput
                    }
                    Binding {
                        target: secondScoreInput
                        property: "text"
                        value:  162 - firstScoreInput.text
                        when: firstScoreInput.acceptableInput
                    }
                }
                ScoreInput { //first declarations
                    id: firstDeclarationsInput
                    Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    minimalValue: 0
                    maximalValue: 200
                    text: scores.firstDeclarations
                    Binding {
                        target: scores
                        property: "firstDeclarations"
                        value: firstDeclarationsInput.text
                    }
                }
                ScoreInput { //second score
                    id: secondScoreInput
                    Layout.preferredWidth: appWindow.largeScoreWidth
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    minimalValue: 0
                    maximalValue: 162
                    Component.onCompleted: {
                        text = scores.secondScore
                    }
                    Binding {
                        target: scores
                        property: "secondScore"
                        value: secondScoreInput.text
                        when: secondScoreInput.acceptableInput
                    }
                    Binding {
                        target: firstScoreInput
                        property: "text"
                        value: 162 - secondScoreInput.text
                        when: secondScoreInput.acceptableInput
                    }
                }
                ScoreInput { //second declarations
                    id: secondDeclarationsInput
                    Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    minimalValue: 0
                    maximalValue: 200
                    text: scores.secondDeclarations
                    Binding {
                        target: scores
                        property: "secondDeclarations"
                        value: secondDeclarationsInput.text
                    }
                }
                Item { //filler
                    Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 10
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                }
                ScoreInput { //bid
                    id: bidInput
                    Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: appWindow.minimumScoreWidth
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    minimalValue: 8
                    maximalValue: 200
                    text: scores.bid
                    Binding {
                        target: scores
                        property: "bid"
                        value: bidInput.text
                    }
                }
                Button { //capot
                    id: capotInput
                    Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 25
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    text: 'K'
                    font.pixelSize: Math.min(height, width) / 2.1
                    checkable: true
                    checked: scores.isCapot
                    onClicked: { scores.isCapot ^= true }
                }
                ComboBox { //contras
                    id: contrasInput
                    Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 40
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    indicator: Item{}
                    leftPadding: (width - font.pixelSize) / 2 - 13 // to center options
                    font.pixelSize: Math.min(height, width) / 2.1
                    model: [" -", "Q", " S"] // there are some spaces for somewhat correct padding
                    currentIndex: Math.log2(scores.modifier)
                    Binding {
                        target: scores
                        property: "modifier"
                        value: Math.pow(2, contrasInput.currentIndex)
                    }
                }
                ComboBox { //trump
                    id: trumpInput
                    Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumWidth: 45
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                    indicator: Item{}
                    leftPadding: (width - font.pixelSize) / 2 - 15 // to center options
                    font.pixelSize: Math.min(height, width) / 2.1
                    model: ['❤️', '♠️', '♦️', '♣️', " A"] // there is a space before 'A' for somewhat correct padding
                    currentIndex: scores.trump
                    Binding {
                        target: scores
                        property: "trump"
                        value: trumpInput.currentIndex
                    }
                }
                Item { //filler
                    Layout.fillWidth: true
                    Layout.preferredHeight: appWindow.scoreHeight
                    Layout.minimumHeight: appWindow.minimumScoreHeight
                }
            }
        }
    }
    
    footer: Rectangle {

        width: appWindow.width
        height: Math.max(2 * appWindow.scoreHeight, 2 * appWindow.minimumScoreHeight)
        color: (Universal.theme == Universal.Light ? "light" : "dark") + "blue"
        Universal.theme: Universal.System

        RowLayout {
            anchors.fill: parent
            //first row
            ScoreInput { //first score
                id: currentFirstScore
                Layout.preferredWidth: appWindow.largeScoreWidth
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
            ScoreInput { //first declarations
                id: currentFirstDeclarations
                Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: appWindow.minimumScoreWidth
                Layout.minimumHeight: appWindow.minimumScoreHeight
                minimalValue: 0
                maximalValue: 200
                text: '0'
            }
            ScoreInput { //second score
                id: currentSecondScore
                Layout.preferredWidth: appWindow.largeScoreWidth
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
            ScoreInput { //second declarations
                id: currentSecondDeclarations
                Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: appWindow.minimumScoreWidth
                Layout.minimumHeight: appWindow.minimumScoreHeight
                minimalValue: 0
                maximalValue: 200
                text: '0'
            }
            Item { //filler
                Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 10
                Layout.minimumHeight: appWindow.minimumScoreHeight
            }
            ScoreInput { //bid
                id: currentBid
                Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: appWindow.minimumScoreWidth
                Layout.minimumHeight: appWindow.minimumScoreHeight
                minimalValue: 8
                maximalValue: 200
            }
            Button { //capot
                id: currentCapotStatus
                Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 25
                Layout.minimumHeight: appWindow.minimumScoreHeight
                text: 'K'
                font.pixelSize: Math.min(height, width) / 2.1
                checkable: true
            }
            ComboBox { //contras
                id: currentModifier
                Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 40
                Layout.minimumHeight: appWindow.minimumScoreHeight
                indicator: Item{}
                leftPadding: (width - font.pixelSize) / 2 - 13 // to center options
                font.pixelSize: Math.min(height, width) / 2.1
                model: [" -", "Q", " S"] // there are some spaces for somewhat correct padding
            }
            ComboBox { //trump
                id: currentTrump
                Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 45
                Layout.minimumHeight: appWindow.minimumScoreHeight
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
                Layout.preferredWidth: Math.min(appWindow.smallScoreWidth, height)
                Layout.preferredHeight: appWindow.scoreHeight
                Layout.minimumWidth: 25
                Layout.minimumHeight: appWindow.minimumScoreHeight
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
                            "secondScore": Number.fromLocaleString(currentSecondScore.text),
                            "secondDeclarations": Number.fromLocaleString(currentSecondDeclarations.text),
                            "bid": Number.fromLocaleString(currentBid.text),
                            "isCapot":  currentCapotStatus.checked,
                            "modifier": Math.pow(2, currentModifier.currentIndex),
                            "trump": currentTrump.currentIndex
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
