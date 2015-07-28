From: William Towle <william.towle@codethink.co.uk>
Date: Tue, 28 Jul 2015 16:17:44 +0000
Subject: [PATCH 2/2] ARM: shmobile: lager dts: specify default-input for ADV7612
Message-Id: <1438100264-17280-3-git-send-email-william.towle@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1438100264-17280-1-git-send-email-william.towle@codethink.co.uk>
In-Reply-To: <1438100264-17280-1-git-send-email-william.towle@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org, linux-kernel@lists.codethink.co.uk
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org

Set 'default-input' property for ADV7612. Enables image/video capture
without the need to have userspace specifying routing.

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
Tested-by: William Towle <william.towle@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index aec7db6..e537052 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -552,6 +552,7 @@
 		port {
 			hdmi_in_ep: endpoint {
 				remote-endpoint = <&vin0ep0>;
+				default-input = <0>;
 			};
 		};
 	};
-- 
1.7.10.4

