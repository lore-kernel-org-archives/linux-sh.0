From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jul 2008 19:16:23 +0000
Subject: Re: problems opening console
Message-Id: <20080722191623.GA21006@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4885EC04.4060708@spesonline.com>
In-Reply-To: <4885EC04.4060708@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 22, 2008 at 04:17:40PM +0200, Luca Santini wrote:
> (in init/main.c ;  init_post(void) function)
> 
> the rootfs seems correctly mounted and the devices /dev/console and 
> /dev/ttySC2 are present in the filesystem.
> 
> anybody can help me?

Post the full boot log and your .config.
