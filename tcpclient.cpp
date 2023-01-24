#include "tcpclient.h"

TcpClient::TcpClient(QObject *parent)
    : QObject{parent}
{
    m_socket = new QTcpSocket;
}

bool TcpClient::connect()
{
    m_socket->connectToHost(ip, port,QTcpSocket::ReadWrite);
        if (m_socket->waitForConnected(1000))
              return 1;
        else {
            qDebug()<<"Connection failed";
            return 0;
        }
}

bool TcpClient::disconnect()
{
    m_socket->disconnectFromHost();
    if (m_socket->state() == QAbstractSocket::UnconnectedState
         || m_socket->waitForDisconnected(1000)) {
             qDebug("Disconnected!");
             return 1;
     }
    else return 0;
}

bool TcpClient::send(Message m)
{
    //char* temp;
    QByteArray sendTcpData;
    sendTcpData.resize(sizeof(m));
    memcpy(sendTcpData.data(),&m,sizeof(m));
    int detect = m_socket->write(sendTcpData);

    m_socket->flush();
    sendTcpData.clear();
    sendTcpData.squeeze();

    if(detect != -1){
        qDebug()<<"client send to client OK";
        qDebug()<<"Amount:"<<m.number;
        qDebug()<<m.info_name;
        qDebug()<<m.info_password;
        return 1;
    }
    else return 0;

}

Message TcpClient::receive()
{
    Message result,*temp;
    int detect = m_socket->waitForReadyRead(30000);
    if(detect == -1){
        result.type = '6';
        return result;
    }

    this->receiveMessage = m_socket->readAll();
    temp=NULL;
    if(!this->receiveMessage.isEmpty()){
        memset(&result,0,sizeof(Message));
        temp = (Message*)this->receiveMessage.data();

        for(int i=0;i<16;++i){
            result.info_name[i]=temp->info_name[i];
            result.info_password[i]=temp->info_password[i];
        }
        result.number=temp->number;
        result.status = temp->status;
        result.type=temp->type;
    }
    else{
        result.type='6';
        result.status = false;
    }
    //free(temp);
    return result;
}
