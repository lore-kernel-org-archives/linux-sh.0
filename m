From: Stephen Boyd <sboyd@codeaurora.org>
Date: Tue, 28 Aug 2012 00:27:05 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Add compilation support for dtbs using 'make dtbs'
Message-Id: <503C1059.10300@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1346113322-21133-1-git-send-email-horms@verge.net.au>
 <1346113322-21133-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1346113322-21133-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 8/27/2012 5:22 PM, Simon Horman wrote:
> +dtb-$(CONFIG_MACH_KZM9D) += emev2-kzm9d.dts
> +dtb-$(CONFIG_MACH_ARMADILLO800EVA) += r8a7740-armadillo800eva.dts

Shouldn't these be dtb instead of dts?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

