From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Sun, 02 Mar 2008 20:19:09 +0000
Subject: MTD types
Message-Id: <8b67d60803021219k23ca6c6bt2ce2fb2c61cda42e@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, dwmw2@infradead.org
Cc: linux-sh <linux-sh@vger.kernel.org>

A long time ago I took some work Paul Mundt did and used to build a
working driver for the Sega Dreamcast Visual Memory Unit flash memory.

I am now trying to revive that for 2.6 kernels.

In the past the flash was simply described as MTD_OTHER - but I see from:

http://lkml.org/lkml/2006/4/13/151

that type was axed as it was thought unused (not unreasonable - my &
Paul's driver resided in the Dreamcast Linux CVS, not anywhere near
mainline).

I am loathe to just post a patch adding it back, so does it make any
difference if I use another type (I really have no idea of what the
physical type used in the Dreamcast is, though possibly someone here
might?)

Adrian
