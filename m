From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 Nov 2013 05:34:41 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791: Fix DU pin groups organisation
Message-Id: <CANqRtoRHck3Aha6iwn=HBtsH-xfOR5E3nM9_i9Vfv57DkOOsHw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384346777-888-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384346777-888-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Linus,

On Tue, Nov 19, 2013 at 5:16 PM, Linus Walleij <linus.walleij@linaro.org> w=
rote:
> On Wed, Nov 13, 2013 at 1:46 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
>
>> Rename the sync_1 group to sync as the device has a single sync pin
>> group for the DU, move the cde_disp mux array right after the
>> corresponding pins array, and split the clk_in pins in three separate
>> groups as the pins can be used independently.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.c=
om>
>
> Patch applied for v3.14.

Thanks for your help!

I realize that this patch depends on "[PATCH] sh-pfc: r8a7791 PFC
support V2" which I assumed was targeted for v3.13, or do you plan to
push that for v3.14?

>> The patch is based on top of the latest pinctrl for-next branch and is a
>> candidate for v3.14. I've tested it with the DU driver on a Koelsch boar=
d.
>
> K=F6lsch! Who names a board after the sweetest dialect in Germany??

Actually, I've heard that the R-Car series of boards are named after
different types of beer. At least I am aware of Lager, but Koelsch and
Marzen?

Thanks,

/ magnus
