import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import userExample 1.0
import tcpClientExample 1.0
import QtQuick.Dialogs 1.3
import "./MyQmlObject"

Rectangle {
    width: parent.width
    height: parent.height


    MyMessageDialog {
        id: userWrong
        text: "此账号或密码有问题"
        onYes: close()
    }
    MessageDialog {
        id: networkWrong
        text: "网络出错"
        onYes: close()
    }

    Row{
        spacing:10
        x:10
        y:10

        Text{
            text:"用户名输入:"
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:usernameInput
            }
        }
    }

    Row{
        spacing:10
        x:10
        y:50

        Text{
            text:"密码输入:"
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:userpasswordInput
            }
        }
    }

    signal loginSig(string name,string passWord)

    Button{
        id:loginButton
        x:100
        y:100
        text:qsTr("登录")

        style:MyButtonStyle{}

        onClicked:{

            if(client.connect()){
                console.log("Connected OK")
                loginSig(usernameInput.text,userpasswordInput.text)
                console.log("loginSig OK")
                client.send(user.s_sendMessage())
                console.log("client send OK")
                user.set_receiveLoginMessage(client.receive())
                if(user.t_type() === '6'){
                    networkWrong.open();
                }
                else if(user.t_type()=== '5'){
                    client.disconnect()
                    userWrong.open();
                }
                else{
                     usernameInput.clear()
                     userpasswordInput.clear()
                     myStackView.push(mainPage)
                }
            }
            else{
                networkWrong.open();
            }

        }
    }

    Connections{
        target:LoginPage.item
        function onLoginSig(name,password){
            user.loginSlot(name,password)
            console.log(name)
        }
    }

    Button{
        id:registerButton
        x:200
        y:100
        text:qsTr("注册")

        style:MyButtonStyle{}

        onClicked: myStackView.push(registerPage)
    }
}
