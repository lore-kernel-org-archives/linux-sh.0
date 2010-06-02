From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 02 Jun 2010 09:10:52 +0000
Subject: Re: [PATCH v2] sh_tmu: compute mult and shift before registration
Message-Id: <4C06201C.5040508@aurel32.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Paul Mundt a =E9crit :
> On Mon, May 31, 2010 at 11:45:48PM +0200, Aurelien Jarno wrote:
>> Since commit 98962465ed9e6ea99c38e0af63fe1dcb5a79dc25 ("nohz: Prevent
>> clocksource wrapping during idle"), the CPU of an R2D board never goes
>> to idle. This commit assumes that mult and shift are assigned before
>> the clocksource is registered. As a consequence the safe maximum sleep
>> time is negative and the CPU never goes into idle.
>>
>> This patch fixes the problem by moving mult and shift initialization
>> from sh_tmu_clocksource_enable() to sh_tmu_register_clocksource().
>>
>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>=20
> Applied, thanks.
>=20
> I've made a similar change for the sh_cmt driver, too.
>=20
> Both of these should show up in the next 2.6.34-stable release.
>=20

Thanks!


--=20
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
