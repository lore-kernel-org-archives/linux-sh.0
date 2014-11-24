From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 24 Nov 2014 21:11:40 +0000
Subject: Re: [PATCH/RFC 2/3] ARM: shmobile: kzm9g-reference dts: Move Ethernet node to BSC
Message-Id: <54739F0C.7040802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416859808-18503-1-git-send-email-geert+renesas@glider.be> <1416859808-18503-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416859808-18503-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 11/24/2014 11:10 PM, Geert Uytterhoeven wrote:

> Move the Ethernet node from the root of the device tree to the BSC node,
> as it is connected to the Bus State Controller.  This allows the system
> to know the right position of the Ethernet node in the clock and PM
> domain hierarchy.

> Also rename the node's name from "lan9220" to "ethernet", to confirm to

    s/confirm/comply/, you mean?

> ePAPR generic name recomendations.

    Thank you, I've never found the time to rename those device nodes.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

WBR, Sergei

