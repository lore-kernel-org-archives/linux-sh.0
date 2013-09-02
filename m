From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 02 Sep 2013 10:59:45 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo: fixup ether pinctrol naming
Message-Id: <52246FA1.8080605@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02-09-2013 14:37, Laurent Pinchart wrote:

>> e5c9b4cd665106d9b5397114ea81a53059410b6a
>> (sh_eth: get R8A7740 support out of #ifdef)
>> exchanged sh-eth driver name to r8a7740-gether,
>> but, eva_pinctrl_map[] didn't follow it.
>> This patch fixes it.

>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> I've taken the patch in my tree and will push it to v3.13.

    Why to 3.13 if this is a bug fix?

WBR, Sergei

