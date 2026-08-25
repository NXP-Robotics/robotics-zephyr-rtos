if(SB_CONFIG_BOOTLOADER_MCUBOOT)
  set(mcuboot_EXTRA_CONF_FILE
      ${CMAKE_CURRENT_LIST_DIR}/mcuboot/mr_mcxn_t1_mcxn947_cpu0.conf
      CACHE INTERNAL "MCUboot Kconfig fragment for mr_mcxn_t1"
  )
  set(mcuboot_EXTRA_DTC_OVERLAY_FILE
      ${CMAKE_CURRENT_LIST_DIR}/mcuboot/mr_mcxn_t1_mcxn947_cpu0.overlay
      CACHE INTERNAL "MCUboot DTS overlay for mr_mcxn_t1"
  )

  if(SHIELD MATCHES "mr_mcxn_t1_optical_flow")
    list(APPEND mcuboot_EXTRA_CONF_FILE
         ${CMAKE_CURRENT_LIST_DIR}/mcuboot/mr_mcxn_t1_mcxn947_cpu0_optical_flow.conf)
    set(mcuboot_EXTRA_CONF_FILE ${mcuboot_EXTRA_CONF_FILE}
        CACHE INTERNAL "" FORCE)
  endif()
endif()
