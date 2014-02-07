From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 07 Feb 2014 13:05:17 +0000
Subject: Re: [PATCH v3] sh_eth: add device tree support
Message-Id: <52F4DA0D.5070009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402060258.57025.sergei.shtylyov@cogentembedded.com> <20140207012902.GH19799@verge.net.au>
In-Reply-To: <20140207012902.GH19799@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nobuhiro.iwamatsu.yj@renesas.com, rob@landley.net, linux-doc@vger.kernel.org

Hello.

On 07-02-2014 5:29, Simon Horman wrote:

>> Add support of the device tree probing for the Renesas SH-Mobile SoCs
>> documenting the device tree binding as necessary.

>> This work is loosely based on the original patch by Nobuhiro Iwamatsu
>> <nobuhiro.iwamatsu.yj@renesas.com>.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Acked-by: Simon Horman <horms+renesas@verge.net.au>

>> ---
>> This patch is against DaveM's 'net-next.git' repo but should also apply to the
>> recent 'renesas.git' repo's 'devel' branch. It assumes the patch documenting all
>> Ethernet bindings in one file to be applied as well.
>> Not posting it to netdev@vger.kernel.org this time, or Dave will scold me. :-)

> I would prefer if such orthogonal dependencies weren't introduced.
> I'm quite fine if you want to refactor things, but from my point
> of view it would be nice to tackle such projects after merging new features.

    I don't agree. I didn't want to repeat e.g. all the values for "phy-mode" 
prop for the Nth time, hence I suggested that I'd gather all Ethernet props in 
the single file first and got a consent from the bindings reviewer.

WBR, Sergei

