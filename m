From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 12 Mar 2013 14:54:42 +0000
Subject: Re: Serial port RTPM/Suspend issues
Message-Id: <20130312145442.GA20355@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <CABYn4szDUQpgsSErNV6e+f8z9-FdpzzZkhafC5qELdK=kWk6=w@mail.gmail.com>
In-Reply-To: <CABYn4szDUQpgsSErNV6e+f8z9-FdpzzZkhafC5qELdK=kWk6=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 12, 2013 at 03:50:42PM +0100, Bastian Hecht wrote:
> To avoid confusion, let me add: Garbage is produced when waking, not
> in the shutdown process.

I assume this is just data left in the FIFO that hasn't been drained that
comes back in an undefined state due to losing the clock?
