From: Simon Horman <horms@verge.net.au>
Date: Mon, 19 Nov 2012 01:16:28 +0000
Subject: Re: [PATCH v2] ARM: shmobile: mackerel: Add FLCTL IRQ resource
Message-Id: <20121119011628.GA1515@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1353062171-20589-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1353062171-20589-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 16, 2012 at 11:36:11AM +0100, Bastian Hecht wrote:
> Since commit 3c7ea4eccfd2e the sh_flctl driver requires the error IRQ line to
> signal failed transactions between the flash controller and the NAND chip.
> This information is mandatory - else the driver refuses to start up. We
> provide it here for the board mackerel.

Thanks, I have pushed this into a new boards3 branch and
will get send it as a pull-request to the arm-soc people shortly.
