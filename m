From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 25 Sep 2014 16:28:39 +0000
Subject: [PATCH v3 12/13] ARM: shmobile: r8a7740 dtsi: Add preliminary PM domain latencies
Message-Id: <1411662520-22795-13-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

For now use 250 =C2=B5s, just like the legacy platform code does.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New, split off from "ARM: shmobile: r8a7740 dtsi: Add PM domain
    support".

 arch/arm/boot/dts/r8a7740.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 4fead480a405bebe..ed0adeb61a1ad8ec 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -563,16 +563,22 @@
 				pd_a4lc: a4lc@1 {
 					reg =3D <1>;
 					#power-domain-cells =3D <0>;
+					power-on-latency =3D <250000>;
+					power-off-latency =3D <250000>;
 				};
=20
 				pd_a4mp: a4mp@2 {
 					reg =3D <2>;
 					#power-domain-cells =3D <0>;
+					power-on-latency =3D <250000>;
+					power-off-latency =3D <250000>;
 				};
=20
 				pd_d4: d4@3 {
 					reg =3D <3>;
 					#power-domain-cells =3D <0>;
+					power-on-latency =3D <250000>;
+					power-off-latency =3D <250000>;
 				};
=20
 				pd_a4r: a4r@5 {
@@ -580,10 +586,14 @@
 					#address-cells =3D <1>;
 					#size-cells =3D <0>;
 					#power-domain-cells =3D <0>;
+					power-on-latency =3D <250000>;
+					power-off-latency =3D <250000>;
=20
 					pd_a3rv: a3rv@6 {
 						reg =3D <6>;
 						#power-domain-cells =3D <0>;
+						power-on-latency =3D <250000>;
+						power-off-latency =3D <250000>;
 					};
 				};
=20
@@ -592,26 +602,36 @@
 					#address-cells =3D <1>;
 					#size-cells =3D <0>;
 					#power-domain-cells =3D <0>;
+					power-on-latency =3D <250000>;
+					power-off-latency =3D <250000>;
=20
 					pd_a3sp: a3sp@11 {
 						reg =3D <11>;
 						#power-domain-cells =3D <0>;
+						power-on-latency =3D <250000>;
+						power-off-latency =3D <250000>;
 					};
=20
 					pd_a3sm: a3sm@12 {
 						reg =3D <12>;
 						#power-domain-cells =3D <0>;
+						power-on-latency =3D <250000>;
+						power-off-latency =3D <250000>;
 					};
=20
 					pd_a3sg: a3sg@13 {
 						reg =3D <13>;
 						#power-domain-cells =3D <0>;
+						power-on-latency =3D <250000>;
+						power-off-latency =3D <250000>;
 					};
 				};
=20
 				pd_a4su: a4su@20 {
 					reg =3D <20>;
 					#power-domain-cells =3D <0>;
+					power-on-latency =3D <250000>;
+					power-off-latency =3D <250000>;
 				};
 			};
 		};
--=20
1.9.1

