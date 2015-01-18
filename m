From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niso@kth.se>
Date: Sun, 18 Jan 2015 12:20:01 +0000
Subject: [PATCH v2 1/4] sh-pfc: add macro to define pinmux without function
Message-Id: <1421583604-27256-2-git-send-email-niso@kth.se>
List-Id: <linux-sh.vger.kernel.org>
References: <1421583604-27256-1-git-send-email-niso@kth.se>
In-Reply-To: <1421583604-27256-1-git-send-email-niso-UNjuZkX4dYU@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niso-UNjuZkX4dYU@public.gmane.org>

Used to define pinmux configurations where the pinmux function have no
representation in the configuration registers but instead solely depends
on a group selection.

Signed-off-by: Niklas S=C3=B6derlund <niso@kth.se>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pf=
c.h
index 5b72831..c837286 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -167,6 +167,8 @@ struct sh_pfc_soc_info {
 	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr)
 #define PINMUX_IPSR_NOGM(ispr, fn, ms)					\
 	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ms)
+#define PINMUX_IPSR_NOFN(ipsr, fn, ms)					\
+	PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)
 #define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
 	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr, FN_##ms)
 #define PINMUX_IPSR_MODSEL_DATA(ipsr, fn, ms)				\
--=20
2.2.1

