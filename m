From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Mar 2010 11:06:21 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <aec7e5c31003170406i9f6f18cwed8b572187db91cc@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Mar 17, 2010 at 8:02 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> In data mercoled=EC 17 marzo 2010 07:47:35, Magnus Damm ha scritto:
> : > > =A0git clone
>> > =A0git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git
>
> This si not patched with SMSC911X_SWAP_FIFO;

It certainly is there in my tree:

damm@t400s ~/git/sh-2.6 $ git log -1 --oneline | head -n 1
3f7581d serial: sh-sci: remove duplicated #include
damm@t400s ~/git/sh-2.6 $ grep SMSC911X_SWAP_FIFO
arch/sh/boards/mach-rsk/devices-rsk7203.c
	.flags		=3D SMSC911X_USE_32BIT | SMSC911X_SWAP_FIFO,
damm@t400s ~/git/sh-2.6 $ grep SMSC911X_SWAP_FIFO drivers/net/smsc911x.c
	if (pdata->config.flags & SMSC911X_SWAP_FIFO) {
	if (pdata->config.flags & SMSC911X_SWAP_FIFO) {
damm@t400s ~/git/sh-2.6 $

/ magnus
