From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Oct 2010 15:33:28 +0000
Subject: Re: [PATCH] sh: boards/mach-x3proto: gpio: fix error handling code
Message-Id: <20101011153328.GB12338@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1286731708-17822-1-git-send-email-segooon@gmail.com>
In-Reply-To: <1286731708-17822-1-git-send-email-segooon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 10, 2010 at 09:28:27PM +0400, Vasiliy Kulikov wrote:
> Checks for (irq < 0) and (ilsel < 0) didn't make sense since they were
> unsigned.  Made them signed.
> 
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>

Applied, thanks.
