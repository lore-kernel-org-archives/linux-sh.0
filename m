From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Mon, 25 Jan 2016 09:11:44 +0000
Subject: Re: [RFC] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <56A5E6D0.4040704@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 25.01.2016 09:59, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Fri, Jan 22, 2016 at 1:26 PM, Dirk Behme <dirk.behme@de.bosch.com> wro=
te:
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>> Notes:
>>
>> * This is based on https://git.kernel.org/cgit/linux/kernel/git/horms/re=
nesas-bsp.git/commit/drivers/clk/shmobile/clk-rcar-gen3.c?h=3Dv4.2/rcar-3.0=
.x&id=CD10385afc15cef6bfbaea4aa5da41193b24fe82
>>
>> * This is compile tested *only*. The intention is to get some feedback
>>    if this is the way we want to go.
>
> I didn't look into all details, but in general this is what I intended.
> Thanks!


Great, thanks! :)


Wolfram: Maybe you like to include this [1] in your testing branch, then?

If it works for you, I'll remove the RFC, then.


Best regards

Dirk


[1] http://marc.info/?l=3Dlinux-sh&m=145346559429931

See also

https://github.com/dirkbehme/linux-renesas-rcar-gen3/commit/018438cf8ff31e6=
6a6511b4aa0b51e47a39392ed

https://github.com/dirkbehme/linux-renesas-rcar-gen3/commit/f31b7e18f89c447=
ad0d3b31c64cf360afe7d1d9f



