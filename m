From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Tue, 22 Dec 2009 16:18:16 +0000
Subject: AW: Probably cache synchronization issue on SH7723
Message-Id: <95F51F4B902CAC40AF459205F6322F0133E18561C7@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

Lacking some understanding of the caching system I'm not sure why in update=
_cache() some dirty pages are skipped. The following patch fixes my problem=
, but I'm not sure about any negative side effects.


diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index e9415d3..30c3d7e 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -136,8 +136,7 @@ void __update_cache(struct vm_area_struct *vma,
                if (dirty) {
                        unsigned long addr =3D (unsigned long)page_address(=
page);

-                       if (pages_do_alias(addr, address & PAGE_MASK))
-                               __flush_purge_region((void *)addr, PAGE_SIZ=
E);
+                        __flush_purge_region((void *)addr, PAGE_SIZE);
                }
        }
 }

Best regards,
Markus Pietrek

-----Urspr=FCngliche Nachricht-----
Von: linux-sh-owner@vger.kernel.org [mailto:linux-sh-owner@vger.kernel.org]=
 Im Auftrag von Paul Mundt
Gesendet: Freitag, 4. Dezember 2009 07:48
An: Magnus Damm
Cc: Pietrek, Markus; linux-sh@vger.kernel.org
Betreff: Re: Probably cache synchronization issue on SH7723

On Thu, Dec 03, 2009 at 09:45:28PM +0900, Magnus Damm wrote:
> On Thu, Dec 3, 2009 at 9:36 PM, Markus Pietrek
> <Markus.Pietrek@emtrion.de> wrote:
> > when starting bigger graphical applications they suddenly stop with a
> > segmentation fault or a bus error. If I execute the application a second
> > time, everything is fine. Applications that are linked to shared librar=
ies
> > are more likely to fail than statically linked applications.
> >
> > Changing the cache from write-back to write-through fixes it. Maybe the
> > instruction cache and the data cache are not synchronized correctly?
> >
> > I didn't have this problem with the linux-2.6.29 vanilla kernel. 2.6.32=
rc2
> > from git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6 introd=
uced
> > it. And after a pull yesterday even /bin/init is failing.
>
> I've found that sh7722 and sh7724 doesn't work with copy back cache
> right now, see below. There may be other issues as well, but going
> back to OK fixes it for my initramfs-only case.
>
I've reverted the problematic parts of this patch for now, so that should
fix up these cases. There's an outstanding issue addressed by Matt's
patch that is being debugged now and which I will push once the remaining
faults on SH7724 have been resolved.

In any event, these changes are bound for 2.6.33, so stock 2.6.32 should
never have been impacted by any of this, and the remaining issues should
be sorted before 2.6.33-rc1. We'll give it another spin for 2.6.34.
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch=E4ftsf=FChrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or other=
wise confidential information.
- If you have received this e-mail in error, you are hereby notified that a=
ny review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
