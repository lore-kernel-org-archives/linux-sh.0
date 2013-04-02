From: Stephane Grosjean <s.grosjean@peak-system.com>
Date: Tue, 02 Apr 2013 07:47:40 +0000
Subject: Re: drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit declaration of function 'ioport_unm
Message-Id: <515A8D1C.5010308@peak-system.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130327083110.GB11489@localhost>
In-Reply-To: <20130327083110.GB11489@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Marc,

Le 27/03/2013 11:22, Marc Kleine-Budde a =E9crit :
> On 03/27/2013 10:41 AM, Paul Mundt wrote:
>> On Wed, Mar 27, 2013 at 04:31:10PM +0800, Fengguang Wu wrote:
>>> Hi Stephane,
>>>
>>> FYI, kernel build failed on
>>>
>>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux ma=
ster
>>> head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
>>> commit: 2b61972b74219d21ef1e91178349bdb840357688 can: sja1000: add supp=
ort for PEAK-System PCMCIA card
>>> date:   1 year, 1 month ago
>>> config: make ARCH=3Dsh allyesconfig
>>>
>>> All error/warnings:
>>>
>>>     In file included from drivers/net/can/sja1000/peak_pcmcia.c:28:0:
>>>     drivers/net/can/sja1000/sja1000.h:59:0: warning: "REG_SR" redefined=
 [enabled by default]
>>>     arch/sh/include/asm/ptrace_32.h:25:0: note: this is the location of=
 the previous definition
>>>     drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_free':
>>>>> drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit declarat=
ion of function 'ioport_unmap' [-Werror=3Dimplicit-function-declaration]
>>>     drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_probe':
>>>>> drivers/net/can/sja1000/peak_pcmcia.c:672:2: error: implicit declarat=
ion of function 'ioport_map' [-Werror=3Dimplicit-function-declaration]
>>>     drivers/net/can/sja1000/peak_pcmcia.c:672:20: warning: assignment m=
akes pointer from integer without a cast [enabled by default]
>>>     cc1: some warnings being treated as errors
>>>
>> This would no doubt be due to the defconfig selecting NO_IOPORT. This
>> driver probably needs a HAS_IOPORT depends.

> Stephane, can we use pcmcia_map_mem_page() instead of ioport_map() like
> in the ems_pcmcia driver?
>
> http://lxr.free-electrons.com/source/drivers/net/can/sja1000/ems_pcmcia.c=
#L286


Ok, I'll have a look to that asap.
Meanwhile, adding the HAS_IOPORT depends in=20
drivers/net/can/sja1000/Kconfig does the trick. What do you think about=20
that?

BR,

St=E9phane
> Marc
>

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
