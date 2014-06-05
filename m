From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Jun 2014 00:31:47 +0000
Subject: Re: [PATCH 1/2] ARM: lager: enable i2c devices
Message-Id: <20140605003147.GB10759@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392224674-5328-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392224674-5328-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 12, 2014 at 05:04:33PM +0000, Ben Dooks wrote:
> Add i2c0, i2c1, i2c2 and i2c3 nodes to the Lager reference device tree as
> these busses all have devices on them that can be probed even if they
> are no drivers yet.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

I have queued up the following.

There was some fuzz when applying this patch, please check that the
following is correct.

From: Ben Dooks <ben.dooks@codethink.co.uk>

ARM: shmobile: lager: enable i2c devices

Add i2c0, i2c1, i2c2 and i2c3 nodes to the Lager reference device tree as
these busses all have devices on them that can be probed even if they
are no drivers yet.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[horms+renesas@verge.net.au: Added shmobile to title]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 9d4d304..ee80788 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -324,3 +324,19 @@
 &cpu0 {
 	cpu0-supply = <&vdd_dvfs>;
 };
+
+&i2c0	{
+	status = "ok";
+};
+
+&i2c1	{
+	status = "ok";
+};
+
+&i2c2	{
+	status = "ok";
+};
+
+&i2c3	{
+	status = "ok";
+};
-- 
2.0.0.rc2

