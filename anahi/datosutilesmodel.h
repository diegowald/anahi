#ifndef DATOSUTILESMODEL_H
#define DATOSUTILESMODEL_H

#include <QAbstractListModel>

class DatosUtilesModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum DatoUtilRole {
        FullNameRole = Qt::DisplayRole,
        AddressRole = Qt::UserRole,
        CityRole,
        NumberRole,
        CategoriaRole,
        TypeRole
    };
    Q_ENUM(DatoUtilRole)

    enum DatoUtilType {
        Map,
        Telephone,
        WhatsApp,
        Web
    };
    Q_ENUM(DatoUtilType)

public:
    DatosUtilesModel(QObject *parent = nullptr);
    virtual ~DatosUtilesModel() {}

    int rowCount(const QModelIndex & = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE void append(const QString &fullName, const QString &address, const QString  &city, const QString &number);
    Q_INVOKABLE void set(int row, const QString &fullName, const QString &address, const QString  &city, const QString &number);
    Q_INVOKABLE void remove(int row);

private:
    struct DatoUtil {
        QString fullName;
        QString address;
        QString city;
        QString number;
        QString categoria;
        DatoUtilType tipo;
    };

    QList<DatoUtil> m_datoUtil;
};


#endif // DATOSUTILESMODEL_H
