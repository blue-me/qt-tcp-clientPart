#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpsocket>
#include "message.h"

class TcpClient : public QObject
{
    Q_OBJECT
public:
    explicit TcpClient(QObject *parent = nullptr);
    Q_INVOKABLE bool connect();
    Q_INVOKABLE bool disconnect();
    Q_INVOKABLE bool send(Message m);
    Q_INVOKABLE Message receive();
signals:

private:
    QByteArray sendMessage;
    QByteArray receiveMessage;
    QTcpSocket *m_socket;
    QString ip = "127.0.0.1";
    quint16 port = 8888;
};

#endif // TCPCLIENT_H
