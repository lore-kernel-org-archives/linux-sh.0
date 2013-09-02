From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 02 Sep 2013 14:07:32 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo: fixup ether pinctrol naming
Message-Id: <52249BA4.4010709@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/02/2013 06:02 PM, Sergei Shtylyov wrote:

>> e5c9b4cd665106d9b5397114ea81a53059410b6a
>> (sh_eth: get R8A7740 support out of #ifdef)
>> exchanged sh-eth driver name to r8a7740-gether,
>> but, eva_pinctrl_map[] didn't follow it.
>> This patch fixes it.

>     You're too quick to blame my patch. It was just merged in the same

    Although, I probably misread your changelog, and you didn't blame my patch 
but just didn't mention another patch which modified eva_pinctrl_map[]. 
Anyway, it would have been good if you mentioned that other commit.

WBR, Sergei

