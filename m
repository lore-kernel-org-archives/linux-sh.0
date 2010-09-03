From: Jonathan Nieder <jrnieder@gmail.com>
Date: Fri, 03 Sep 2010 18:43:51 +0000
Subject: [BUG?] rename patch accepted with --dry-run, rejected without (Re:
Message-Id: <20100903184351.GC2341@burratino>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
 <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
 <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
 <20100903182323.GA17152@pengutronix.de>
In-Reply-To: <20100903182323.GA17152@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, git@vger.kernel.org, bug-patch@gnu.org

(+cc: bug-patch)

Hi,

Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:

>> Using --dry-run is fine, but omitting dry-run gives me:
>>=20
>> ...
>> patching file arch/arm/common/clkdev.c
>> patching file arch/sh/include/asm/clkdev.h
>> Hunk #1 FAILED at 1.
>> Hunk #2 FAILED at 11.
>> 2 out of 2 hunks FAILED -- saving rejects to file
>> arch/sh/include/asm/clkdev.h.rej
>>=20
>> I guess this is caused by the last "renaming" hunk, see below.

Yep, I can reproduce this.  Patch applies with "git apply",
"patch --dry-run -p1" accepts it, "patch -p1" fails.

 $ patch --version | head -1
 GNU patch 2.6.1.85-423d
 $ cd ~/src/linux-2.6
 $ git checkout 2bfc96a12
 $ git clean -fd
 $ wget http://download.gmane.org/gmane.linux.ports.sh.devel/8747/8748
 $ patch -p1 --quiet --dry-run <8748=20
 $ echo $?
 0
 $ patch -p1 --quiet <8748=20
 2 out of 2 hunks FAILED -- saving rejects to file include/linux/clkdev.h.r=
ej
 $ echo $?
 1

Andreas: ideas?
