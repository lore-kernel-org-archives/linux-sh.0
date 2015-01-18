From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niso@kth.se>
Date: Sun, 18 Jan 2015 12:20:04 +0000
Subject: [PATCH v2 4/4] ARM: shmobile: emev2-kzm9d: Add PFC information for uart1
Message-Id: <1421583604-27256-5-git-send-email-niso@kth.se>
List-Id: <linux-sh.vger.kernel.org>
References: <1421583604-27256-1-git-send-email-niso@kth.se>
In-Reply-To: <1421583604-27256-1-git-send-email-niso-UNjuZkX4dYU@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niso-UNjuZkX4dYU@public.gmane.org>

Configure the pinmux on kzm9d to use the serial connector for uart1.

Signed-off-by: Niklas S=C3=B6derlund <niso@kth.se>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kz=
m9d.dts
index 667d323..1944627 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -94,3 +94,16 @@
 		vdd33a-supply =3D <&reg_3p3v>;
 	};
 };
+
+&pfc {
+	uart1_pins: uart@e1030000 {
+		renesas,groups =3D "uart1_ctrl", "uart1_data";
+		renesas,function =3D "uart1";
+	};
+};
+
+&uart1 {
+	pinctrl-0 =3D <&uart1_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
--=20
2.2.1

