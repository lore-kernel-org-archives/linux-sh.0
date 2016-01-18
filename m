From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Jan 2016 01:41:14 +0000
Subject: Re: [PATCH] ARM: shmobile: silk: add DU DT support
Message-Id: <20160118014114.GC1905@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <20467499.tt8XqkxVqn@wasted.cogentembedded.com>
In-Reply-To: <20467499.tt8XqkxVqn@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jan 13, 2016 at 02:06:08AM +0300, Sergei Shtylyov wrote:
> Define  the SILK board dependent part of the DU device node.
> Add the device nodes for the Analog Devices ADV7511W HDMI transmitter
> (connected to DU0) and ADV7123  video DAC (connected to DU1). Add the
> necessary subnodes to interconnect DU, HDMI/VDAC devices, and HDMI/VGA
> connectors.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up for v4.6 after updating the subject with
s/shmobile/dts/ to reflect a request made from the ARM SoC maintainers
regarding prefixes for DT patches.
