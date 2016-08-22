From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 22 Aug 2016 11:04:53 +0000
Subject: Re: [PATCH] sh: clkfwk: remove unnecessary for failing to alloc mem
Message-Id: <e1fc8e8b-c2cb-b8f3-8872-4bcf9fe60100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1471855132-15448-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1471855132-15448-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 8/22/2016 11:38 AM, Shawn Lin wrote:

> kzalloc will print err there, so we don't need this extra one.

    s/err/error/?

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
[...]

MBR, Sergei

