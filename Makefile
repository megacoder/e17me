TARGETS	=all check clean clobber diff distclean import install         \
         uninstall pull
TARGET	=all

.PHONY:	${TARGETS} update

PREFIX	=/opt
BINDIR	=${PREFIX}/bin
PYPATH	=${PREFIX}/lib/python2.7/site-packages

NAME	=easy_efl.sh
URL	=http://omicron.homeip.net/projects/easy_efl/dev/${NAME}

#ARGS	=--install
ARGS	=

# all::	install
all::	update

install:: easy_efl.sh x.easy_efl.conf
	./wrapper ./easy_efl.sh --conf=x.easy_efl.conf -i

update:: easy_efl.sh x.easy_efl.conf
	./wrapper ./easy_efl.sh --conf=x.easy_efl.conf -u

check::	easy_efl.sh
	./wrapper ./easy_efl.sh ${ARGS}

clean::
	${RM} a.out core.* lint tags

distclean clobber:: clean

diff::	${HOME}/.easy_efl.conf x.easy_efl.conf
	diff -uNp ${HOME}/.easy_efl.conf x.easy_efl.conf
diff::	${BINDIR}/easy_efl easy_efl.sh
	diff -uNp ${BINDIR}/easy_efl easy_efl.sh

install:: x.easy_efl.conf easy_efl.sh
	install -D -c -m 0644 x.easy_efl.conf ${HOME}/.easy_efl.conf
	sudo install -D -c -m 0755 easy_efl.sh ${BINDIR}/easy_efl

uninstall::
	${RM} ${HOME}/.easy_efl.conf ${BINDIR}/easy_efl

import:: ${HOME}/.easy_efl.conf
	cp ${HOME}/.easy_efl.conf x.easy_efl.conf

pull::
	[ ! -f easy_efl.sh ] || mv easy_efl.sh easy_efl.sh-old
	${RM} easy_efl.sh easy_efl.sh
	wget -c "${URL}"
	chmod +x "${NAME}"
