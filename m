From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 03 Dec 2010 04:44:06 +0000
Subject: Re: [PATCH 2/2] sh: se/7724: Update clock of FSI to non-legacy
Message-Id: <AANLkTim_yHiv-ewstJBnZV1Xn0kTM=Ci38va6s45VHqs@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1291349817-3077-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1291349817-3077-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

2010/12/3 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Dear Paul, Iwamatsu-san
>
>> > Current FSI clock of ecovec uses legacy clock.
>> > This update to non-legacy.
>> >
>> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> > ---
>> > =A0arch/sh/boards/mach-se/7724/setup.c | =A0 16 ++++++++++++++--
>> > =A01 files changed, 14 insertions(+), 2 deletions(-)
>> >
>> For ecovec and 7724 clock framework we already have the patch from
>> Morimoto-san queued up, perhaps se7724 needs the same fix?
>>
>> =A0 =A0 =A0 http://git.kernel.org/?p=3Dlinux/kernel/git/lethal/sh-2.6.gi=
t;a=3Dcommitdiff;hKd5d259e451d35380de2fcd1a3510ae22d000a3
>
> Ohh... I'm sorry.
> I forgot to modify mach-se/7724/setup.c in above patch.
>
>>> Iwamatsu san
>
> Can you update it ?

Sure. Please wait.

Best regards,
  Nobuhiro
--=20
Nobuhiro Iwamatsu
