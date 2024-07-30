cmake_minimum_required(VERSION 3.16)
project(app LANGUAGES CXX)

include(qt.cmake)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 REQUIRED COMPONENTS Core QuickControls2)
find_package(Qt${QT_VERSION_MAJOR}
    COMPONENTS
        Quick QuickControls2
)
qt_standard_project_setup()

set(PROJECT_SOURCES
    main.cpp
)

if(QT_VERSION VERSION_LESS 6.2)
    list(APPEND PROJECT_SOURCES qml.qrc)
endif()

qt_add_executable(app ${PROJECT_SOURCES})

if(QT_VERSION VERSION_GREATER_EQUAL 6.2)
    qt_add_qml_module(app
        URI app
        VERSION 1.0
        RESOURCE_PREFIX "/qt/qml/"
        QML_FILES
            main.qml qml_resources/ScoreInput.qml qml_resources/ScoreName.qml
        RESOURCES icons/question.png icons/settings.png
    )
endif()

set_target_properties(app
    PROPERTIES
        WIN32_EXECUTABLE TRUE
)

target_link_libraries(app
    PUBLIC
        Qt::Quick Qt6::QuickControls2
)

if(Qt6_FOUND)
    qt_import_qml_plugins(app)
endif()
