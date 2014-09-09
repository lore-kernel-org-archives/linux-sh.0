From: Kevin Hilman <khilman@kernel.org>
Date: Tue, 09 Sep 2014 15:57:50 +0000
Subject: Re: [PATCH/RFC 1/5] PM / Domains: Add DT bindings for power-on/off latencies
Message-Id: <7h8ulskcqp.fsf@deeprootsystems.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410183344-14756-1-git-send-email-geert+renesas@glider.be>
 <1410183344-14756-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1410183344-14756-2-git-send-email-geert+renesas@glider.be>
 (Geert Uytterhoeven's message of "Mon, 8 Sep 2014 15:35:40 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> PM domain power on/off-latencies are properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Nice.

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
