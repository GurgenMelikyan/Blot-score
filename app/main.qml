import QtQuick 2.9
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
    enum Suits {
        Heart,
        Spade,
        Diamond,
        Club,
        NoTrump
    }
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
        height: Math.max(appWindow.height / 10, 50)
        ScoreName {
            Layout.preferredWidth: appWindow.width / 3
            Layout.preferredHeight: appWindow.height / 20
            Layout.minimumWidth: 38
            Layout.minimumHeight: 50
            text: "Մենք"
        }
        ScoreName {
            Layout.preferredWidth: Math.min(appWindow.width / 22, height)
            Layout.preferredHeight: appWindow.height / 20
            Layout.minimumWidth: 50
            Layout.minimumHeight: 50
            text: "Դրսից1"
        }
        ScoreName {
            Layout.preferredWidth: appWindow.width / 3
            Layout.preferredHeight: appWindow.height / 20
            Layout.minimumWidth: 38
            Layout.minimumHeight: 50
            text: "Դուք"
        }
        ScoreName {
            Layout.preferredWidth: Math.min(appWindow.width / 22, height)
            Layout.preferredHeight: appWindow.height / 20
            Layout.minimumWidth: 50
            Layout.minimumHeight: 50
            text: "Դրսից2"
        }
        Item {  //filler
            Layout.preferredWidth: Math.min(appWindow.width / 22, height)
            Layout.minimumWidth: 10
            Layout.preferredHeight: appWindow.height / 20
        }
        ScoreName {
            Layout.preferredWidth: Math.min(appWindow.width / 22, height)
            Layout.preferredHeight: appWindow.height / 20
            Layout.minimumWidth: 50
            Layout.minimumHeight: 50
            text: "Խոսացած"
        }
        Item { //filler
            Layout.fillWidth: true
            Layout.preferredHeight: appWindow.height / 20
            Layout.minimumHeight: 50
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

            height: Math.max(scores.ListView.view.height / 10, 50)
            width: scores.ListView.view.width
        
            RowLayout {
                anchors.fill: parent
                //first row
                ScoreInput { //first score
                    Layout.preferredWidth: appWindow.width / 3
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 38
                    Layout.minimumHeight: 25
                    minimalValue: 0
                    maximalValue: 162
                    text: scores.firstScore
                }
                ScoreInput { //first declarations
                    Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 38
                    Layout.minimumHeight: 25
                    minimalValue: 0
                    maximalValue: 200
                    text: scores.firstDeclarations
                }
                ScoreInput { //second score
                    Layout.preferredWidth: appWindow.width / 3
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 38
                    Layout.minimumHeight: 25
                    minimalValue: 0
                    maximalValue: 162
                    text: scores.secondScore
                }
                ScoreInput { //second declarations
                    Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 38
                    Layout.minimumHeight: 25
                    minimalValue: 0
                    maximalValue: 200
                    text: scores.secondDeclarations
                }
                Item { //filler
                    Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 10
                    Layout.minimumHeight: 25
                }
                ScoreInput { //bid
                    Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 38
                    Layout.minimumHeight: 25
                    minimalValue: 8
                    maximalValue: 200
                    text: scores.bid
                }
                Button { //capot
                    Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 25
                    Layout.minimumHeight: 25
                    text: 'K'
                    font.pixelSize: Math.min(height, width) / 2.1
                    checkable: true
                    checked: scores.isCapot
                    onClicked: {scores.isCapot ^= true; console.log(scores.isCapot)}
                }
                ComboBox { //contras
                    Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 40
                    Layout.minimumHeight: 25
                    indicator: Item{}
                    leftPadding: (width - font.pixelSize) / 2 - 13 // to center options
                    font.pixelSize: Math.min(height, width) / 2.1
                    model: [" -", "Q", " S"] // there are some spaces for somewhat correct padding
                }
                ComboBox { //trump
                    Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumWidth: 45
                    Layout.minimumHeight: 25
                    indicator: Item{}
                    leftPadding: (width - font.pixelSize) / 2 - 15 // to center options
                    font.pixelSize: Math.min(height, width) / 2.1
                    model: ['❤️', '♠️', '♦️', '♣️', " A"] // there is a space before 'A' for somewhat correct padding
                }
                Item { //filler
                    Layout.fillWidth: true
                    Layout.preferredHeight: appWindow.height / 20
                    Layout.minimumHeight: 25
                }
            }
        }
    }
    
    footer: Rectangle {

        width: appWindow.width
        height: Math.max(appWindow.height / 10, 50)
        color: (Universal.theme == Universal.Light ? "light" : "dark") + "blue"
        Universal.theme: Universal.System

        RowLayout {
            anchors.fill: parent
            //first row
            ScoreInput { //first score
                Layout.preferredWidth: appWindow.width / 3
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 38
                Layout.minimumHeight: 25
                minimalValue: 0
                maximalValue: 162
            }
            ScoreInput { //first declarations
                Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 38
                Layout.minimumHeight: 25
                minimalValue: 0
                maximalValue: 200
            }
            ScoreInput { //second score
                Layout.preferredWidth: appWindow.width / 3
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 38
                Layout.minimumHeight: 25
                minimalValue: 0
                maximalValue: 162
            }
            ScoreInput { //second declarations
                Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 38
                Layout.minimumHeight: 25
                minimalValue: 0
                maximalValue: 200
            }
            Item { //filler
                Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 10
                Layout.minimumHeight: 25
            }
            ScoreInput { //bid
                Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 38
                Layout.minimumHeight: 25
                minimalValue: 8
                maximalValue: 200
            }
            Button { //capot
                Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 25
                Layout.minimumHeight: 25
                text: 'K'
                font.pixelSize: Math.min(height, width) / 2.1
                checkable: true
            }
            ComboBox { //contras
                Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 40
                Layout.minimumHeight: 25
                indicator: Item{}
                leftPadding: (width - font.pixelSize) / 2 - 13 // to center options
                font.pixelSize: Math.min(height, width) / 2.1
                model: [" -", "Q", " S"] // there are some spaces for somewhat correct padding
            }
            ComboBox { //trump
                Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 45
                Layout.minimumHeight: 25
                indicator: Item{}
                leftPadding: (width - font.pixelSize) / 2 - 15 // to center options
                font.pixelSize: Math.min(height, width) / 2.1
                model: ['❤️', '♠️', '♦️', '♣️', " A"] // there is a space before 'A' for somewhat correct padding
            }
            Item { //filler
                Layout.fillWidth: true
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumHeight: 25
            }
            RoundButton { // add button
                Layout.preferredWidth: Math.min(appWindow.width / 22, height)
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumWidth: 25
                Layout.minimumHeight: 25
                text: '+'
                font.pixelSize: Math.min(height, width) / 2.1
                highlighted: true
            }
            Item { //filler
                Layout.minimumWidth: 10
                Layout.preferredHeight: appWindow.height / 20
                Layout.minimumHeight: 25
            }
        }
    }
}
