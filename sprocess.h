#ifndef SPROCESS_H
#define SPROCESS_H

#include <QProcess>


class SProcess : public QProcess
{
    Q_OBJECT
public:
    SProcess(QObject *parent = nullptr);

public slots:
    void start(const QString &program, const QVariantList &arguments);

    QByteArray readAll();

    QByteArray readAllStandardOutput();

    QByteArray readAllStandardError();
};

#endif // SPROCESS_H
