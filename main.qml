import QtQuick 2.14
import QtQuick.Window 2.15
import QtQuick.Controls 2.14
import QtQuick.Controls.Styles 1.4
import QtQml 2.14
import userExample 1.0
import tcpClientExample 1.0
Window {
    id:window

    visible: true
    width: 360
    height: 640
    title: qsTr("Hello World")

    User{
        id:user
    }
    TcpClient{
        id:client
    }

    //选项的两页面
    Loader{
        id:myLoader
        anchors.centerIn: parent
    }
    Component.onCompleted: myLoader.sourceComponent=loginPage


    Component{
        id:loginPage
        LoginPage {
            anchors.centerIn: parent
        }

    }

    Component{
        id:registerPage
        RegisterPage {
            anchors.centerIn: parent
        }
    }

    Component{
        id:mainPage
        MainPage {
            anchors.centerIn: parent
        }
    }

    //业务范围
    Component{
        id:transferPage
        TransferPage {
            anchors.centerIn: parent
        }
    }

    Component{
        id:checkPage
        CheckPage {
            anchors.centerIn: parent
        }
    }

    Component{
        id:savePage
        SavePage {
            anchors.centerIn: parent
        }
    }

    Component{
        id:drawPage
        DrawPage {
            anchors.centerIn: parent
        }
    }
}
