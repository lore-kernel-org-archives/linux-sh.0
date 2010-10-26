From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 26 Oct 2010 00:08:12 +0000
Subject: Re: [PATCH] sh: i2c-sh7760: Replase from ctrl_* to __raw_*
Message-Id: <AANLkTikh+h1nWHZCa29FQc1dw=z3ZhYEW8eSyFyS4C84@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1287785220-5893-1-git-send-email-iwamatsu@nigauri.org>
 <20101025015835.GE2173@linux-sh.org> <20101025104718.GF21564@trinity.fluff.org>
 <20101025111324.GA16265@linux-sh.org> <20101025124211.GG21564@trinity.fluff.org>
In-Reply-To: <20101025124211.GG21564@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ben Dooks <ben-i2c@fluff.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

2010/10/25 Ben Dooks <ben-i2c@fluff.org>:
> On Mon, Oct 25, 2010 at 08:13:25PM +0900, Paul Mundt wrote:
>> On Mon, Oct 25, 2010 at 11:47:18AM +0100, Ben Dooks wrote:
>> > On Mon, Oct 25, 2010 at 10:58:35AM +0900, Paul Mundt wrote:
>> > > On Sat, Oct 23, 2010 at 07:07:00AM +0900, Nobuhiro Iwamatsu wrote:
>> > > > ctrl_* is deprecated. We should to use __raw_*.
>> > > >
>> > > > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> > >
>> > > Applied, thanks.
>> >
>> > Hi, can you see my comments about the copy of this posted below
>> > about ioremap() and use or __raw accessors?
>> >
>> No? At least it never made it to the list. Do you have a pointer handy?
>
> http://marc.info/?l=3Dlinux-i2c&m=128797023230600&w=3D2
>

Sorry, this is my mistake.

>> On Sun, Oct 24, 2010 at 05:37:46PM +0900, Nobuhiro Iwamatsu wrote:
>> ctrl_* is deprecated. We should to use __raw_*.
>
>> Given iobase is ioremap() returned, there should be an explicit reason
>> for using __raw_xxx() instead of read/writel().

ioread32 / iowrite32?

Best regarads,
  Nobuhiro
--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
