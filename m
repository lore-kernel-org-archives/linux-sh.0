From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 20 Jun 2013 08:04:07 +0000
Subject: Re: [PATCH v2 2/2] gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific sections
Message-Id: <1653091.GeQyMLF6L8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1371551389-5493-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1667096.lqpXoD2UlE@avalon>
 <CACRpkdZJ1Hg=4w1fySiMgy0-Qdph1pD0OZGLFecxHhTsMEKQog@mail.gmail.com>
In-Reply-To: <CACRpkdZJ1Hg=4w1fySiMgy0-Qdph1pD0OZGLFecxHhTsMEKQog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Linus,

On Thursday 20 June 2013 08:42:23 Linus Walleij wrote:
> On Wed, Jun 19, 2013 at 9:51 PM, Laurent Pinchart wrote:
> > On Wednesday 19 June 2013 21:17:35 Linus Walleij wrote:
> >> On Tue, Jun 18, 2013 at 12:29 PM, Laurent Pinchart wrote:
> >> > All functions and data types used by OF-specific code paths are
> >> > declared
> >> > in <linux/of.h> regardless of CONFIG_OF. Replace the #ifdef CONFIG_OF
> >> > guard with a if(IS_ENABLED(CONFIG_OF)) and let the compiler optimize
> >> > the unused code away.
> >> >=20
> >> > Signed-off-by: Laurent Pinchart
> >> > <laurent.pinchart+renesas@ideasonboard.com>
> >>=20
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >=20
> > Thank you. Can you please take the patch in your tree ?
>=20
> No. It does not apply:
>=20
> ]$ git am --signoff rcar-fix.patch
> Till=E4mpar: gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific sectio=
ns
> error: patch misslyckades: drivers/gpio/gpio-rcar.c:279
> error: drivers/gpio/gpio-rcar.c: patchen kan inte till=E4mpas
> Patchen misslyckades vid 0001 gpio-rcar: Remove #ifdef CONFIG_OF
> around OF-specific sections
> En kopia av patchen som misslyckades finns i:
>    /home/linus/src/linux-trees/linux-gpio/.git/rebase-apply/patch
> N=E4r du har l=F6st problemet k=F6r du "git am --resolved".
> Om du vill hoppa =F6ver patchen k=F6r du ist=E4llet "git am --skip".
> F=F6r att =E5terst=E4lla originalgrenen och avbryta k=F6r du "git am --ab=
ort".
>=20
>=20
> Isn't this RCAR stuff funneled through ARM SoC this merge window?
> Then you have to send it to the ARM SoC folks corresponding branch.

Oops, my bad. I had mistaken it for one of the pinctrl patches.

/me needs to sleep more :-)

--=20
Regards,

Laurent Pinchart

