From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Sep 2014 11:06:40 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Remove legacy C board code
Message-Id: <540847C0.6060300@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904023440.26241.39089.sendpatchset@w520>
In-Reply-To: <20140904023440.26241.39089.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 9/4/2014 6:34 AM, Magnus Damm wrote:

> From: Magnus Damm <damm+renesas@opensource.se>

> The Multiplatform r8a7790 Lager board code is at this point
> in equally or better state compared to the legacy code.

    I think it's a bit premature to say this. For example, USBHS DT support 
hasn't been merged (the .dts[i] part hasn't even been posted yet IIRC).
The USB PHY DT support also hasn't been merged.

> Because of that it is now a good time to get rid of the old
> code and force all users move over to Multiplatform.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

WBR, Sergei

