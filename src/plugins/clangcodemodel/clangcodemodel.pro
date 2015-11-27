include(../../qtcreatorplugin.pri)
include(../../shared/clang/clang_installation.pri)

LIBS += $$LLVM_LIBS
INCLUDEPATH += $$LLVM_INCLUDEPATH
DEFINES += CLANGCODEMODEL_LIBRARY

# The following defines are used to determine the clang include path for intrinsics.
DEFINES += CLANG_VERSION=\\\"$${LLVM_VERSION}\\\"
DEFINES += "\"CLANG_RESOURCE_DIR=\\\"$${LLVM_LIBDIR}/clang/$${LLVM_VERSION}/include\\\"\""

unix:QMAKE_LFLAGS += -Wl,-rpath,\'$$LLVM_LIBDIR\'

SOURCES += \
    activationsequencecontextprocessor.cpp \
    activationsequenceprocessor.cpp \
    clangassistproposal.cpp \
    clangassistproposalitem.cpp \
    clangassistproposalmodel.cpp \
    clangbackendipcintegration.cpp \
    clangcodemodelplugin.cpp \
    clangcompletionassistinterface.cpp \
    clangcompletionassistprocessor.cpp \
    clangcompletionassistprovider.cpp \
    clangcompletioncontextanalyzer.cpp \
    clangdiagnosticfilter.cpp \
    clangdiagnosticmanager.cpp \
    clangeditordocumentparser.cpp \
    clangeditordocumentprocessor.cpp \
    clangfixitoperation.cpp \
    clangfixitoperationsextractor.cpp \
    clangfunctionhintmodel.cpp \
    clangmodelmanagersupport.cpp \
    clangprojectsettings.cpp \
    clangprojectsettingspropertiespage.cpp \
    clangtextmark.cpp \
    clangutils.cpp \
    completionchunkstotextconverter.cpp \
    highlightingmarksreporter.cpp \
    pchinfo.cpp \
    pchmanager.cpp \
    raii/scopedclangoptions.cpp \
    unit.cpp \
    unsavedfiledata.cpp

HEADERS += \
    activationsequencecontextprocessor.h \
    activationsequenceprocessor.h \
    clangassistproposal.h \
    clangassistproposalitem.h \
    clangassistproposalmodel.h \
    clangbackendipcintegration.h \
    clangcodemodelplugin.h \
    clangcompletionassistinterface.h \
    clangcompletionassistprocessor.h \
    clangcompletionassistprovider.h \
    clangcompletioncontextanalyzer.h \
    clangdiagnosticfilter.h \
    clangdiagnosticmanager.h \
    clangeditordocumentparser.h \
    clangeditordocumentprocessor.h \
    clangfixitoperation.h \
    clangfixitoperationsextractor.h \
    clangfunctionhintmodel.h \
    clang_global.h \
    clangmodelmanagersupport.h \
    clangprojectsettings.h \
    clangprojectsettingspropertiespage.h \
    clangtextmark.h \
    clangutils.h \
    completionchunkstotextconverter.h \
    constants.h \
    highlightingmarksreporter.h \
    pchinfo.h \
    pchmanager.h \
    raii/scopedclangoptions.h \
    unit.h \
    unsavedfiledata.h

FORMS += clangprojectsettingspropertiespage.ui

equals(TEST, 1) {
    HEADERS += \
        test/clangcodecompletion_test.h

    SOURCES += \
        test/clangcodecompletion_test.cpp

    RESOURCES += test/data/clangtestdata.qrc
    OTHER_FILES += $$files(test/data/*)
}

macx {
    LIBCLANG_VERSION=3.3
    POSTL = install_name_tool -change "@executable_path/../lib/libclang.$${LIBCLANG_VERSION}.dylib" "$$LLVM_INSTALL_DIR/lib/libclang.$${LIBCLANG_VERSION}.dylib" "\"$${DESTDIR}/lib$${TARGET}.dylib\"" $$escape_expand(\\n\\t)
    !isEmpty(QMAKE_POST_LINK):QMAKE_POST_LINK = $$escape_expand(\\n\\t)$$QMAKE_POST_LINK
    QMAKE_POST_LINK = $$POSTL $$QMAKE_POST_LINK
}
