From: Conrad Parker <conrad@metadecks.org>
Date: Fri, 10 Apr 2009 18:37:05 +0000
Subject: libshcodecs 0.9.5 Release
Message-Id: <dba6c0830904101137q6703cf9an9ba35f95dc8b695a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

libshcodecs 0.9.5 Release
============
libshcodecs is a library for controlling SH-Mobile hardware codecs.

The [SH-Mobile][0] processor series includes a hardware video processing
unit that supports MPEG-4 and H.264 encoding and decoding.
libshcodecs is available under the terms of the GNU LGPL.

The source archive, and more information about the library are available from:

        http://linux-sh.org/cgi-bin/moin.cgi/libshcodecs

New in this release
=========
        * Re-instated finalization of H.264 stream decoding

        * Removed the separate libshenc encoder library

        * Added a minimal decoder example, in
src/examples/shcodecs-decode-qvga-mpeg4.c

        * Updated shared version info to 5:0:1


[0]: http://www.renesas.com/fmwk.jsp?cnt=sh_mobile_family_landing.jsp&fp=/products/mpumcu/sh_mobile/
