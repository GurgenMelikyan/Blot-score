import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Controls.Universal

TextField {
    required property int minimalValue
    required property int maximalValue
    Universal.theme: Universal.System
    font.pixelSize: Math.min(height, width) / 2.6
    horizontalAlignment: TextField.AlignHCenter
    verticalAlignment: TextField.AlignVCenter
    validator: IntValidator{bottom: minimalValue; top: maximalValue}
}