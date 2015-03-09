From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 09 Mar 2015 23:49:34 +0000
Subject: Re: Can't boot kernel v4.0-rc2 on Koelsch
Message-Id: <9904400.IVpSAFnIyl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <2263226.JPOqZgiCRj@avalon>
In-Reply-To: <2263226.JPOqZgiCRj@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hello Hiep-san,

(CC'ing Geert)

On Monday 09 March 2015 18:43:54 Cao Minh Hiep wrote:
> On 2015年03月09日 16:06, Laurent Pinchart wrote:
> > On Monday 09 March 2015 10:07:04 Cao Minh Hiep wrote:
> >> Hi Laurent-san
> >> 
> >> I am Hiep from Jinzai Solution.
> >> I'm sorry to bother you again!
> > 
> > No worries.
> > 
> >> We are testing the linux ver v4.0-rc2 on Koelsch, We can not boot the
> >> kernel v4.0-rc2 on Koelsch,
> >> Then we found a patch has changed as below:
> >> "1f75cda ARM: shmobile: koelsch: Rename SCIF[01] serial ports to
> >> ttySC[01]"
> >> 
> >> Please see it when you have time!
> > 
> > Could you please detail your boot failure ? You might need to change your
> > /etc/inittab to adjust to the serial port new name, but apart from that
> > there shouldn't be any issue. I can boot my Koelsch board on 4.0-v2.
> 
> Sure, I use the rootfs of Linaro-nano 2014.09 to test v4.0-rc2.
> When booting kernel with default config, bootlogs showed until these
> messages appearing.
> "init: auto-serial-console main process ended, respawning
> init: auto-serial-console main process ended, respawning
> init: auto-serial-console main process ended, respawning
> init: tty1 main process (1449) killed by TERM signal
> init: auto-serial-console respawning too fast, stopped"
> 
> Then, my Koelsch board stoped here.(my Lager board is the same)
> (I attached the bootlogs_file)
> 
> So, When I tried to add "console=ttySC0," into bootargs (at .dts file),
> i can boot my Koelsch board without any problems.
> And these are the same on Lager board.

Thank you for the information.

Geert, it looks like the console= kernel command line argument is used by 
userspace to figure out the console device on which to spawn a terminal. What 
would you think about adding it back ?

> Thank you!
> Jinso/Hiep
> ====> information:
> Actually, on v4.0-rc2, we have two patches related each other as below:
> 79e69d1 ARM: shmobile: koelsch dts:Drop console= bootargs parameter BAD.
> 1f75cda ARM: shmobile: koelsch: Rename SCIF01 serial ports to ttySC01
> 
> And for Lager:
> 569dd56 ARM: shmobile: lager dts: Drop console= bootargs parameter
> 78c11ec ARM: shmobile: lager: Rename SCIFA[01] serial ports to ttySC[01]
> 
> There is only 79e69d1 patch on v3.19-rcX, I also had a problem with
> bootting Koelsch on v3.19-rcX
> (using linaro-nano 2014.09). But it was good on Yocto and
> linaro-nano-2013.02

-- 
Regards,

Laurent Pinchart

