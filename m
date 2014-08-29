From: Simon Horman <horms@verge.net.au>
Date: Fri, 29 Aug 2014 00:00:58 +0000
Subject: Re: [PATCH resend 1/2] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific thermal compatible property
Message-Id: <20140829000058.GG16165@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1409214040-5937-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409214040-5937-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Aug 28, 2014 at 10:20:39AM +0200, Geert Uytterhoeven wrote:
> The thermal node used the generic compatible property only.
> Add the SoC-specific one, to make it future proof.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Resend, doc update is in v3.17-rc1

Thanks, I have queued this up.
