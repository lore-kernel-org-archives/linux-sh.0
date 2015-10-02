From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 02 Oct 2015 11:32:49 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
Message-Id: <560E6B61.5000509@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1443752733.git.horms+renesas@verge.net.au>
 <6507c4efd2ca4a3dccedbc5b4724f9faabf97fca.1443752733.git.horms+renesas@verge.net.au>
 <560E6AAE.9080605@cogentembedded.com>
In-Reply-To: <560E6AAE.9080605@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/2/2015 2:29 PM, Sergei Shtylyov wrote:

>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> 484adb005886 ("ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain")
>> added CPG/MSTP clock-cells domain support, but it was missing sound
>> support. This patch adds it.
>
>     Really? I'm only seeing "power-domains" prop added...

    Oh, I understand now. The log seems somewhat poorly worded though...

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> [horms: Updated commit id referred to in changelog]
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei

