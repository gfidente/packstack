class packstack::neutron::lbaas ()
{
    class { '::neutron::agents::lbaas':
      interface_driver => hiera('CONFIG_NEUTRON_LBAAS_INTERFACE_DRIVER'),
      device_driver    => 'neutron_lbaas.drivers.haproxy.namespace_driver.HaproxyNSDriver',
      user_group       => 'haproxy',
      enable_v1        => false,
      enable_v2        => true,
      debug            => hiera('CONFIG_DEBUG_MODE'),
    }

    class {'::neutron::services::lbaas':
      service_providers => 'LOADBALANCERV2:Haproxy:neutron_lbaas.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver',
    }
}
