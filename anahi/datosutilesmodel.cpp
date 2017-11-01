#include "datosutilesmodel.h"

DatosUtilesModel::DatosUtilesModel(QObject *parent ) : QAbstractListModel(parent)
{
/*    QString fullName;
*/
    m_datoUtil.append( { "Loft Rental", "Brandsen 456", "Bahia Blanca", "http://maps.google.com/maps?daddr=-38.7193941,-62.2544412", "Alojamiento Entrenadores", DatoUtilType::Map, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Andrea Martorelli", "", "Bahia Blanca" , "+5492914147880", "Managers", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Reglamento Rugby infantil", "", "", "http://www.clubchampagnat.com/wp-content/uploads/2015/03/Resumen_Reglamento_RI2015.jpg", "Reglamento", DatoUtilType::Web, QDateTime(QDate(2017, 01, 01), QTime(0, 0, 0)), QDateTime(QDate(2017, 12, 31), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Buscar Hoteles en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=hoteles+en+bahia+blanca", "Para Padres", DatoUtilType::Web, QDateTime(QDate(2017, 01, 01), QTime(0, 0, 0)), QDateTime(QDate(2017, 12, 31), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Buscar Restaurantes en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=restaurantes+en+bahia+blanca", "Para Padres", DatoUtilType::Web, QDateTime(QDate(2017, 01, 01), QTime(0, 0, 0)), QDateTime(QDate(2017, 12, 31), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Buscar Farmacias en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=farmacias+en+bahia+blanca", "Para Padres", DatoUtilType::Web, QDateTime(QDate(2017, 01, 01), QTime(0, 0, 0)), QDateTime(QDate(2017, 12, 31), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Buscar Hospitales en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=hospital+en+bahia+blanca", "Para Padres", DatoUtilType::Web, QDateTime(QDate(2017, 01, 01), QTime(0, 0, 0)), QDateTime(QDate(2017, 12, 31), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Buscar Taxi en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=taxi+en+bahia+blanca", "Para Padres", DatoUtilType::Web, QDateTime(QDate(2017, 01, 01), QTime(0, 0, 0)), QDateTime(QDate(2017, 12, 31), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Buscar cajeros automáticos", "", "Bahia Blanca", "https://www.google.com.ar/search?q=cajero+automatico+en+bahia+blanca", "Para Padres", DatoUtilType::Web, QDateTime(QDate(2017, 01, 01), QTime(0, 0, 0)), QDateTime(QDate(2017, 12, 31), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Guido Ballesi", "", "Bahia Blanca" , "+5492914433647", "Entrenador M8", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Rodrigo Custodio", "", "Bahia Blanca" , "+5492914169978", "Entrenador M8", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Sebastian Scoppa", "", "Bahia Blanca" , "+5492914127541", "Entrenador M8", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Tomás Vila", "", "Bahia Blanca" , "+5492914130945", "Entrenador Escuelita", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Juan Manuel", "", "Bahia Blanca" , "+5492914668510", "Entrenador Escuelita", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Puru", "", "Bahia Blanca" , "+5492914425391", "Entrenador M9", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Ariel Poison", "", "Bahia Blanca" , "+5492914730289", "Entrenador M9", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Carlos Morales", "", "Bahia Blanca" , "+5492914412057", "Entrenador 10", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Martín Linares", "", "Bahia Blanca" , "+5492916499194", "Entrenador 10", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Ruso Infante", "", "Bahia Blanca" , "+5492916425462", "Entrenador M11", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Pablo Gimenez", "", "Bahia Blanca" , "+5492915038643", "Entrenador M11", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Nicolas Vanoli", "", "Bahia Blanca" , "+549291", "Entrenador M11", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Mauro Masague", "", "Bahia Blanca" , "+5492914705042", "Entrenador M12", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Rafel Journet", "", "Bahia Blanca" , "+5492915720877", "Entrenador M12", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Paulo Temporelli", "", "Bahia Blanca" , "+5492914277391", "Entrenador M12", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });


    m_datoUtil.append( { "Chino Vera", "", "Bahia Blanca" , "+5492914277391", "Entrenador M13", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });
    m_datoUtil.append( { "Mariano De Luca", "", "Bahia Blanca" , "+5492914631828", "Entrenador M13", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Marcelo Spikerman", "", "Bahia Blanca" , "+549291416479", "Entrenador M14", DatoUtilType::WhatsApp, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 11, 7), QTime(23, 59, 59)) });

    m_datoUtil.append( { "Acerca de la aplicación", "", "", "", "Créditos", DatoUtilType::About, QDateTime(QDate(2017, 10, 27), QTime(0, 0, 0)), QDateTime(QDate(2017, 12, 31), QTime(23, 59, 59)) });
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
        case visibleDesdeRole: return m_datoUtil.at(index.row()).visibleDesde;
        case visibleHastaRole: return m_datoUtil.at(index.row()).visibleHasta;
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
        { TypeRole, "tipo"},
        { visibleDesdeRole, "visibleDesde" },
        { visibleHastaRole, "visibleHasta" },
    };
    return roles;
}

QVariantMap DatosUtilesModel::get(int row) const
{
    const DatoUtil contact = m_datoUtil.value(row);
    return { {"fullName", contact.fullName},
        {"address", contact.address},
        {"city", contact.city},
        {"number", contact.number},
        { "categoria", contact.categoria },
        { "tipo", contact.tipo },
        { "visibleDesde", contact.visibleDesde },
        { "visibleHasta", contact.visibleHasta },
    };
}

void DatosUtilesModel::append(const QString &fullName, const QString &address, const QString &city, const QString &number, const QString &categoria, const DatoUtilType tipo, const QDateTime &visibleDesde, const QDateTime &visibleHasta )
{
    int row = 0;
    while (row < m_datoUtil.count() && fullName > m_datoUtil.at(row).fullName)
        ++row;
    beginInsertRows(QModelIndex(), row, row);
    m_datoUtil.insert(row, {fullName, address, city, number, categoria,
                            tipo,
                            visibleDesde,
                            visibleHasta
                      });
    endInsertRows();
}

void DatosUtilesModel::set(int row, const QString &fullName, const QString &address, const QString &city, const QString &number, const QString &categoria, const DatoUtilType tipo, const QDateTime &visibleDesde, const QDateTime &visibleHasta )
{
    if (row < 0 || row >= m_datoUtil.count())
        return;

    m_datoUtil.replace(row, { fullName, address, city, number, categoria, tipo, visibleDesde, visibleHasta });

    dataChanged(index(row, 0), index(row, 0), { FullNameRole, AddressRole, CityRole, NumberRole, CategoriaRole, TypeRole, visibleDesdeRole, visibleHastaRole });
}

void DatosUtilesModel::remove(int row)
{
    if (row < 0 || row >= m_datoUtil.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_datoUtil.removeAt(row);
    endRemoveRows();
}
