From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 03 Dec 2010 04:42:30 +0000
Subject: Re: [PATCH 2/2] sh: se/7724: Update clock of FSI to non-legacy
Message-Id: <AANLkTi=MyK=ThMfADQJRfOK8kE+f0OBFTQFgO+KN2G=r@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1291349817-3077-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1291349817-3077-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2010/12/3 Paul Mundt <lethal@linux-sh.org>:
> On Fri, Dec 03, 2010 at 01:16:57PM +0900, Nobuhiro Iwamatsu wrote:
>> Current FSI clock of ecovec uses legacy clock.
>> This update to non-legacy.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>> =A0arch/sh/boards/mach-se/7724/setup.c | =A0 16 ++++++++++++++--
>> =A01 files changed, 14 insertions(+), 2 deletions(-)
>>
> For ecovec and 7724 clock framework we already have the patch from
> Morimoto-san queued up, perhaps se7724 needs the same fix?
>
> =A0 =A0 =A0 =A0http://git.kernel.org/?p=3Dlinux/kernel/git/lethal/sh-2.6.=
git;a=3Dcommitdiff;hKd5d259e451d35380de2fcd1a3510ae22d000a3

Oh, sorry. These are the same revisions.
Please ignore.

BTW , do yuo have plan that  morimoto-san patch into linus/master?
These cannot build now by your commit
(549015c36baadc6e67861bba6e927259e34c4d59).

Best regards,
  Nobuhiro.


--=20
Nobuhiro Iwamatsu
