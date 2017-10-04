#include "datosutilesmodel.h"

DatosUtilesModel::DatosUtilesModel(QObject *parent ) : QAbstractListModel(parent)
{
/*    QString fullName;
*/
    m_datoUtil.append( { "Lofts XYZ", "Brandsen 456", "Bahia Blanca", "4545454", "Alojamiento", DatoUtilType::Map });
    m_datoUtil.append( { "Buscar Hoteles en Bahia Blanca", "", "Bahia Blanca", "", "Alojamiento", DatoUtilType::Web });
    m_datoUtil.append({ "Andrea", "", "Bahia Blanca" , "1234", "Managers", DatoUtilType::WhatsApp });
    m_datoUtil.append({ "Reglamento Rugby infantil", "", "", "", "Reglamento", DatoUtilType::Web });
    m_datoUtil.append({ "IDEAS??", "", "", "", "IDEAS", DatoUtilType::Web });
}

int DatosUtilesModel::rowCount(const QModelIndex &) const
{
    return m_datoUtil.count();
}

QVariant DatosUtilesModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < rowCount())
        switch (role) {
        case FullNameRole: return m_datoUtil.at(index.row()).fullName;
        case AddressRole: return m_datoUtil.at(index.row()).address;
        case CityRole: return m_datoUtil.at(index.row()).city;
        case NumberRole: return m_datoUtil.at(index.row()).number;
        case CategoriaRole: return m_datoUtil.at(index.row()).categoria;
        case TypeRole: return m_datoUtil.at(index.row()).tipo;
        default: return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> DatosUtilesModel::roleNames() const
{
    static const QHash<int, QByteArray> roles {
        { FullNameRole, "fullName" },
        { AddressRole, "address" },
        { CityRole, "city" },
        { NumberRole, "number" },
        { CategoriaRole, "categoria"},
        { TypeRole, "tipo"}
    };
    return roles;
}

QVariantMap DatosUtilesModel::get(int row) const
{
    const DatoUtil contact = m_datoUtil.value(row);
    return { {"fullName", contact.fullName}, {"address", contact.address}, {"city", contact.city}, {"number", contact.number} };
}

void DatosUtilesModel::append(const QString &fullName, const QString &address, const QString &city, const QString &number)
{
    int row = 0;
    while (row < m_datoUtil.count() && fullName > m_datoUtil.at(row).fullName)
        ++row;
    beginInsertRows(QModelIndex(), row, row);
    m_datoUtil.insert(row, {fullName, address, city, number, "categoria"});
    endInsertRows();
}

void DatosUtilesModel::set(int row, const QString &fullName, const QString &address, const QString &city, const QString &number)
{
    if (row < 0 || row >= m_datoUtil.count())
        return;

    m_datoUtil.replace(row, { fullName, address, city, number, "categpria" });
    dataChanged(index(row, 0), index(row, 0), { FullNameRole, AddressRole, CityRole, NumberRole });
}

void DatosUtilesModel::remove(int row)
{
    if (row < 0 || row >= m_datoUtil.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_datoUtil.removeAt(row);
    endRemoveRows();
}
