From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 May 2012 00:46:04 +0000
Subject: Re: ap4 (sh7372) regression in 3.3 / 3.4 with serial console - boot failures
Message-Id: <20120517004603.GB16069@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1205161431380.30283@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1205161431380.30283@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 16, 2012 at 03:36:10PM +0200, Guennadi Liakhovetski wrote:
> I'm observing a regression with 3.3 and 3.4 kernels, 3.2 seems to be ok. 
> The system (confirmed with mackerel and ap4evb) hangs during boot at 
> random times. This can be directly after "freeing init memory," or some 
> time during the OS start up, or immediately after the start up has 
> completed. But if it managed to boot, it continues to run, I've never seen 
> it hanging after I ssh onto the system. It also seems, that the 
> probability to hang increases with time after the initial system power on. 
> A simple short power off doesn't solve the problem.
> 
So you experience random hangs at boot and you have a known good and
known bad version. If only there were some sort of a bisection tool one
could use..
