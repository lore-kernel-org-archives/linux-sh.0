From: William Towle <william.towle@codethink.co.uk>
Date: Tue, 04 Feb 2014 18:17:35 +0000
Subject: Clock divisor/parent settings changes
Message-Id: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Patches (3x) to ensure we see:
    sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
    sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 48 MHz

Attached:
    [PATCH 1/3] clk: rcar-h2: fix sd0/sd1 divisor table
    [PATCH 2/3] ARM: shmobile: r8a7790: specify multiple parents for
    [PATCH 3/3] clk: shmobile: handle multiple parent clocks for cpg
