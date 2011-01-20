From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Jan 2011 01:00:22 +0000
Subject: Re: linux 2.6.37+ seems to go to sleep
Message-Id: <AANLkTim2gut2SWE-KwMccr+S6h0vhAT8FgcSg_NGCx6b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Fabio,

On Thu, Jan 20, 2011 at 1:19 AM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Hi All,
> using the emulator and u-boot =A0together, I have seen that my kernel sto=
ps into
> sleep instruction.

Sounds like a fully working system to me - the sleep instruction is
normally used by the idle loop for power management purpose.

> How could I avoid this?

Not sure why you would like to do so, but the kernel command line
option "nohlt" may help if you wish to disable CPU core power
managment.

> Is it possible I cannot see anything on the serial terminal because of th=
is
> sleep instruction?

I don't think so. You most likely don't see anything because you have
problems with your serial console.

Why don't you try using "earlyprintk" to get early console printouts
from your SCIF port?

Cheers,

/ magnus
