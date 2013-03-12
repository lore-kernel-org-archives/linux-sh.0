From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 12 Mar 2013 15:31:57 +0000
Subject: Re: Serial port RTPM/Suspend issues
Message-Id: <CABYn4sybMe3vVH-JGm__j9obDtKwR2Mvn-8RpYr2jJ6NopjJfg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CABYn4szDUQpgsSErNV6e+f8z9-FdpzzZkhafC5qELdK=kWk6=w@mail.gmail.com>
In-Reply-To: <CABYn4szDUQpgsSErNV6e+f8z9-FdpzzZkhafC5qELdK=kWk6=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2013/3/12 Paul Mundt <lethal@linux-sh.org>:
> On Tue, Mar 12, 2013 at 03:50:42PM +0100, Bastian Hecht wrote:
>> To avoid confusion, let me add: Garbage is produced when waking, not
>> in the shutdown process.
>
> I assume this is just data left in the FIFO that hasn't been drained that
> comes back in an undefined state due to losing the clock?

The port hangs after printing a couple of dozens of characters. The
system itself seems stable - I can log into it using ssh.
Does this fit with your theory?

By the way I am using a shallow sleep to test it. Just cpu_do_idle().
