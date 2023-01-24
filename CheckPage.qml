import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.10
import QtQml 2.14
import userExample 1.0
import "./MyQmlObject"
Rectangle{
    width:360
    height:640

    Row{
        id:check
        x:10
        y:10
        spacing: 10

        Text{
            id:checkPro
            text:qsTr("您当前还有余额：")
            font.pointSize: 15
        }
        Text{
            id:checkAmount
            text:user.a_amount().toString()
            font.pointSize: 15
        }
    }

    Button{
        id:checkExit
        x:100
        y:100
        text: qsTr("返回")

        style:MyButtonStyle{}

        onClicked:{
            myLoader.sourceComponent = mainPage
        }
    }
}
