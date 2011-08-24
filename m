From: takashi.yoshii.zj@renesas.com
Date: Wed, 24 Aug 2011 11:04:00 +0000
Subject: Re: [PATCH] serial: sh-sci: report CTS as active for get_mctrl
Message-Id: <4E54DAA0.4030008@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4E536466.6020604@renesas.com>
In-Reply-To: <4E536466.6020604@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> This looks reasonable, but what application specifically was hitting
> this? ...

Well, it was detected by pure test. So, actually, nobody is in trouble :)
But I think it occurs on anything that use hardware flow control and write(TX).
Even shell terminal session does. Try invoke "stty crtscts" on your shell.
It will freeze your terminal session whatever its flow control setting is.
Or, do like as followings on ssh session, is safer.
 $ stty -F /dev/ttySC1 clocal crtscts -echo
 $ echo x > /dev/ttySC1
Output 'x' on serial expected, but it stops and no output.

To make things clearer, I've made following test program and ran on sh7785lcr with
free ttySC1 (not used for console, nor shell).

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
main(){
        struct termios t;
        int fd = open("/dev/ttySC1", O_RDWR);
        tcgetattr(fd, &t);
        t.c_cflag |= CRTSCTS;
        tcsetattr(fd, TCSANOW, &t);
        write(fd, "x", 1);
        close(fd);
}

Output 'x' and exit, is expected.
But no output and stops during "close" on last line.
More precisely, it is waiting for event on tty->write_wait at uart_close().

(In addition to close(), ioctl() will be also a case. It waits for outputs done)

/yoshii
